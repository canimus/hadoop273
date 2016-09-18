# -*- mode: ruby -*-
# vi: set ft=ruby :
#
Vagrant.configure("2") do |config|

  # Creation of NameNode and SecondaryNameNode
  config.vm.define "nn" do |nn|
    nn.vm.box = "canimus/hadoop273"
    nn.vm.hostname = "nn"
    # Creating an internal network to communcate the cluster
    nn.vm.network "private_network", ip: "10.10.10.2", virtualbox__intnet: "intnet"
    # Gaining access to the NameNode WebUI from host machine
    nn.vm.network "forwarded_port", guest: 50070, host: 50070

    nn.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end

    nn.vm.provision "chef_solo" do |chef|
      chef.add_recipe "hdphost"
      chef.data_bags_path = "data_bags"
      chef.roles_path = "roles"
      chef.add_role("name_node")
    end

  end
  
  # Creation of 3 DataNodes
  (1..3).each do |i|
   config.vm.define "dn#{i}" do |dn1|
     dn1.vm.box = "canimus/hadoop273"
     dn1.vm.hostname = "dn#{i}"
     dn1.vm.network "private_network", ip: "10.10.10.#{i+2}", virtualbox__intnet: "intnet"

     dn1.vm.provider "virtualbox" do |vb|
       vb.memory = "1020"
     end

     dn1.vm.provision "chef_solo" do |chef|
       chef.add_recipe "hdphost"
       chef.data_bags_path = "data_bags"
       chef.roles_path = "roles"
       chef.add_role("data_node")
     end

   end
  end

end
