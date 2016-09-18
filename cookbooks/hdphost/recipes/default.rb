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
