#
# Cookbook Name:: namenode
# Recipe:: default
# Authr: Herminio Vazquez
# Copyright 2016, IOVIO Big Data
# ==================================

execute "format_name_node" do
  command "bin/hdfs namenode -format"
  cwd "/vagrant/hadoop-2.7.3"
  notifies :run, 'execute[start_name_node]', :immediately
  user "vagrant"
end

execute "start_name_node" do
  command "sbin/hadoop-daemon.sh --config etc/hadoop start namenode"
  cwd "/vagrant/hadoop-2.7.3"
  user "vagrant"
  action :nothing
end

execute "start_secondary_name_node" do
  command "sbin/hadoop-daemon.sh --config etc/hadoop start secondarynamenode"
  cwd "/vagrant/hadoop-2.7.3"
  user "vagrant"
end
