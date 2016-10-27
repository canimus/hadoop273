#
# Cookbook Name:: datanode
# Recipe:: default
# Author: Herminio Vazquez
# Copyright 2016, Iovio Big Data
# ================================

execute "remove_data_folders" do
  command "rm -rf /hadoop/data/dn"
end

execute "create_data_folders" do
  command "mkdir -p /hadoop/data/dn"
end

execute "change_data_owner" do
  command "chown vagrant:vagrant -R /hadoop/data/dn"
end

execute "start_data_node" do
  command "sbin/hadoop-daemon.sh --config etc/hadoop start datanode -Ddfs.datanode.address=`hostname -I | awk '{print $2}'`:50010 -Ddfs.datanode.http.address=`hostname -I | awk '{print $2}'`:50080 -Ddfs.datanode.ipc.address=`hostname -I | awk '{print $2}'`:50020 -Ddfs.datanode.data.dir=file:/hadoop/data/dn"
  cwd "/vagrant/hadoop-2.7.3"
  user "vagrant"
end
