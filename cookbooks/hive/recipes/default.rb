#
# Cookbook Name:: hive
# Recipe:: default
# Author: Herminio Vazquez
# Copyright 2016, Iovio Big Data
# ================================

remote_file "/vagrant/apache-hive-1.2.1-bin.tar.gz" do
  source 'http://apache.rediris.es/hive/hive-1.2.1/apache-hive-1.2.1-bin.tar.gz'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
  notifies :run, 'execute[extract_hive_tar]', :immediately
  not_if { File.exist? "/vagrant/apache-hive-1.2.1-bin.tar.gz"}
end

execute 'extract_hive_tar' do
  command 'tar -xvf apache-hive-1.2.1-bin.tar.gz'
  cwd '/vagrant'
  user 'vagrant'
  action :nothing
  not_if { Dir.exist? "/vagrant/apache-hive-1.2.1-bin/" }
end

template '/vagrant/apache-hive-1.2.1-bin/conf/hive-site.xml' do
  source 'hive-site.xml.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  variables :hive => {
    "dbmetastore" => "jdbc:mysql://localhost:3306/metastoredb",
    "dbdriver" => "com.mysql.jdbc.Driver",
    "dbuser" => "root",
    "dbpassword" => "root"
  }
end

cookbook_file "/vagrant/apache-hive-1.2.1-bin/lib/mysql-connector-java-5.1.40-bin.jar" do
  source 'mysql-connector-java-5.1.40-bin.jar'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  not_if { Dir.exist? "/vagrant/apache-hive-1.2.1-bin/lib/mysql-connector-java-5.1.40-bin.jar" }
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

execute "hive_metastore" do
  command "bin/hdfs dfs -mkdir -p /user/hive/warehouse"
  cwd "/vagrant/hadoop-2.7.3"
  user "vagrant"
end

execute "hdfs_tmp" do
  command "bin/hdfs dfs -mkdir -p /tmp"
  cwd "/vagrant/hadoop-2.7.3"
  user "vagrant"
end

execute "hive_ms_permissions" do
  command "bin/hdfs dfs -chmod g+w /user/hive/warehouse"
  cwd "/vagrant/hadoop-2.7.3"
  user "vagrant"
end

execute "tmp_permissions" do
  command "bin/hdfs dfs -chmod g+w /tmp"
  cwd "/vagrant/hadoop-2.7.3"
  user "vagrant"
end

execute "password_mysql" do
  command "mysqladmin -u root -h localhost password root"
  cwd "/vagrant/apache-hive-1.2.1-bin"
  user "vagrant"
end

execute "create_metastore_db" do
  command "mysql -u root -proot -e \"create database metastoredb; GRANT ALL PRIVILEGES ON metastoredb.* TO root@localhost IDENTIFIED BY 'root'\""
  cwd "/vagrant/apache-hive-1.2.1-bin"
  user "vagrant"
end

execute "schema_init_hive" do
  command "JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre HADOOP_HOME=/vagrant/hadoop-2.7.3 HIVE_HOME=/vagrant/apache-hive-1.2.1-bin bin/schematool -dbType mysql -initSchema"
  cwd "/vagrant/apache-hive-1.2.1-bin"
  user "vagrant"
end
