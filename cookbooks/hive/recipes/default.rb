#
# Cookbook Name:: hive
# Recipe:: default
# Author: Herminio Vazquez
# Copyright 2016, Iovio Big Data
# ================================

remote_file "/vagrant/apache-hive-2.1.0-bin.tar.gz" do
  source 'http://apache.rediris.es/hive/hive-2.1.0/apache-hive-2.1.0-bin.tar.gz'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
  notifies :run, 'execute[extract_hive_tar]', :immediately
  not_if { File.exist? "/vagrant/apache-hive-2.1.0-bin.tar.gz"}
end

execute 'extract_hive_tar' do
  command 'tar -xvf apache-hive-2.1.0-bin.tar.gz'
  cwd '/vagrant'
  user 'vagrant'
  action :nothing
  not_if { Dir.exist? "/vagrant/apache-hive-2.1.0-bin/" }
end

# template '/vagrant/apache-hive-2.1.0-bin/conf/hive-site.xml' do
#   source 'hive-site.xml.erb'
#   owner 'vagrant'
#   group 'vagrant'
#   mode '0755'
#   variables :hdfs => {"server" => "hdfs://10.10.10.20", "port" => "10020"}
# end

cookbook_file "/vagrant/apache-hive-2.1.0-bin/conf/hive-env.sh" do
  source 'hive-env.sh'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
end

execute 'update_sources' do
  command "apt-get update"
  ignore_failure true
end

apt_package 'mysql-server' do
  ignore_failure true
  package_name 'mysql-server'
  action :install
end
