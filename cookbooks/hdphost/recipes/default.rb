#
# Cookbook Name:: hdphost
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
file '/etc/hosts' do
  node_list = search(:cluster, "id:nodes").first
  # When adding the loopback interface
  #partial = "127.0.0.1\t#{node.name}\t#{node.name}\n"
  partial = ""
  node_list.each do |n|
    partial += "#{n[1]}\t#{n[0]}\t#{n[0]}\n" if not n[0].eql?("id")
  end
  content partial
end

remote_file "/vagrant/hadoop-2.7.3.tar.gz" do
  source 'http://apache.rediris.es/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
  notifies :run, 'execute[extract_hadoop_tar]', :immediately
  not_if { File.exist? "/vagrant/hadoop-2.7.3.tar.gz"}
end

execute 'extract_hadoop_tar' do
  command 'tar -xvf hadoop-2.7.3.tar.gz'
  cwd '/vagrant'
  user 'vagrant'
  action :nothing
  not_if { Dir.exist? "/vagrant/hadoop-2.7.3/" }
end

template '/vagrant/hadoop-2.7.3/etc/hadoop/core-site.xml' do
  source 'core-site.xml.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  variables :hdfs => {"server" => "hdfs://10.10.10.2", "port" => "8020"}
end

cookbook_file "/vagrant/hadoop-2.7.3/etc/hadoop/hadoop-env.sh" do
  source 'hadoop-env.sh'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
end
