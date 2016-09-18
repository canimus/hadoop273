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

  (1..3).each do |i|
   config.vm.define "dn#{i}" do |dn1|
     dn1.vm.box = "hadoop273"
     dn1.vm.hostname = "dn#{i}"
     dn1.vm.network "private_network", ip: "10.10.10.#{i+2}.str", virtualbox__intnet: "intnet"

     dn1.vm.provider "virtualbox" do |vb|
       vb.memory = "1020"
     end

     dn1.vm.provision "chef_solo" do |chef|
       chef.add_recipe "hdphost"
       chef.data_bags_path = "data_bags"
     end

   end
  end

end
