#
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Global declaration
Vagrant.configure("2") do |config|
  config.vm.define "sandbox" do |sandbox|
     sandbox.vm.box = "centos/7"
     sandbox.ssh.insert_key = true
     sandbox.vm.synced_folder ".", "/vagrant", disabled: true 
     sandbox.vm.network "public_network", bridge: "Intel(R) 82579LM Gigabit Network Connection"
     sandbox.vm.provider :virtualbox do |v|
        v.memory = 780
        v.name = "sandbox"
     end
     sandbox.vm.provision :shell, path: "bootstrap.sh"
  end
end 

