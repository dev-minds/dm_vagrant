#
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Global declaration
Vagrant.configure("2") do |config|
   config.vm.define "QA" do |varname|
      varname.vm.box = "centos/7"
      varname.ssh.insert_key = true
      varname.vm.network "public_network", bridge: "Intel gigabit"
      varname.vm.provider :virtualbox do |vb|
         vb.memory = 512
         vb.name = "preprod"
      end 
      varname.vm.provision :shell, path: "bootstrap.sh"
   end 
   config.vm.define "Staging" do |varstg|
      varstg.vm.box = "centos/7"
      varstg.ssh.insert_key = true
      varstg.vm.network "public_network", bridge: "Intel gigabit"
      varstg.vm.provider :virtualbox do |vbstg|
         vbstg.memory = 512
         vbstg.name = "Staging"
      end 
      varstg.vm.provision :shell, path: "bootstrap.sh"
   end 
   config.vm.define "Production" do |varprd|
      varprd.vm.box = "centos/7"
      varprd.ssh.insert_key = true
      varprd.vm.network "public_network", bridge: "Intel gigabit"
      varprd.vm.provider :virtualbox do |vbprd|
         vbprd.memory = 512
         vbprd.name = "Production"
      end 
      varprd.vm.provision :shell, path: "bootstrap.sh"
   end 
end 

