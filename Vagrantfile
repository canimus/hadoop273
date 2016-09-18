# -*- mode: ruby -*-
# vi: set ft=ruby :
#
Vagrant.configure("2") do |config|

  config.vm.define "namenode" do |nn|
    nn.vm.box = "hadoop273"
    nn.vm.hostname = "nn"
    nn.vm.network "private_network", ip: "10.10.10.2", virtualbox__intnet: "intnet"
    nn.vm.network "forwarded_port", guest: 50070, host: 50070

    nn.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end

    nn.vm.provision "chef_solo" do |chef|
      chef.add_recipe "hdphost"
      chef.data_bags_path = "data_bags"
    end

  end

  config.vm.define "datanode1" do |dn1|
    dn1.vm.box = "hadoop273"
    dn1.vm.hostname = "dn1"
    dn1.vm.network "private_network", ip: "10.10.10.3", virtualbox__intnet: "intnet"
    dn1.vm.provider "virtualbox" do |vb|
      vb.memory = "1020"
    end
    dn1.vm.provision "chef_solo" do |chef|
      chef.add_recipe "hdphost"
      chef.data_bags_path = "data_bags"
    end
  end 
  
  config.vm.define "datanode2" do |dn2|
    dn2.vm.box = "hadoop273"
    dn2.vm.hostname = "dn2"
    dn2.vm.network "private_network", ip: "10.10.10.4", virtualbox__intnet: "intnet"
    dn2.vm.provider "virtualbox" do |vb|
      vb.memory = "1020"
    end
    dn2.vm.provision "chef_solo" do |chef|
      chef.add_recipe "hdphost"
      chef.data_bags_path = "data_bags"
    end
  end
  
  config.vm.define "datanode3" do |dn3|
    dn3.vm.box = "hadoop273"
    dn3.vm.hostname = "dn3"
    dn3.vm.network "private_network", ip: "10.10.10.5", virtualbox__intnet: "intnet"
    dn3.vm.provider "virtualbox" do |vb|
      vb.memory = "1020"
    end
    dn3.vm.provision "chef_solo" do |chef|
      chef.add_recipe "hdphost"
      chef.data_bags_path = "data_bags"
    end
  end

end
