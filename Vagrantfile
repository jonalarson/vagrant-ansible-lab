# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  config.vm.provider "virtualbox" do |rs|
    rs.memory = 1024
    rs.cpus = 2
  end

  # Will not check for box updates during every startup.
  config.vm.box_check_update = false


  # Master node where ansible will be installed
  config.vm.define "controller" do |controller|
    controller.vm.box = "ubuntu/focal64"
    controller.vm.provider :virtualbox do |vb|
      vb.name = "controller"
      vb.customize ["modifyvm", :id, "--groups", "/Ansible Lab"]
    end  
    controller.vm.hostname = "controller.mieweb.local"
    controller.vm.network "private_network", ip: "192.168.56.3"
    controller.vm.provision "shell", path: "bootstrap.sh"
    controller.vm.provision "file", source: "key_gen.sh", destination: "/home/vagrant/"
    controller.vm.provision "file", source: "Makefile", destination: "/home/vagrant/"
  end

  # DHCP Server
  config.vm.define "dhcpsrvr" do |dhcpsrvr|
    dhcpsrvr.vm.box = "ubuntu/focal64"
    dhcpsrvr.vm.provider :virtualbox do |vb|
      vb.name = "dhcpsrvr"
      vb.customize ["modifyvm", :id, "--groups", "/Ansible Lab"]
    end  
    dhcpsrvr.vm.hostname = "dhcpsrvr.mieweb.local"
    dhcpsrvr.vm.network "private_network", ip: "192.168.56.4"
    dhcpsrvr.vm.provision "shell", path: "bootstrap.sh"
  end

  # DHCP Client
  config.vm.define "dhcpclient" do |dhcpclient|
    dhcpclient.vm.box = "ubuntu/focal64"
    dhcpclient.vm.provider :virtualbox do |vb|
      vb.name = "dhcpclient"
      vb.customize ["modifyvm", :id, "--groups", "/Ansible Lab"]
    end  
    dhcpclient.vm.hostname = "dhcpclient.mieweb.local"
    dhcpclient.vm.network "private_network", ip: "192.168.56.5"
    dhcpclient.vm.provision "shell", path: "bootstrap.sh"
  end

end
