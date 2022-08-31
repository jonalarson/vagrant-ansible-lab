#!/usr/bin/env bash

# vagrant by default creates its own keypair for all the machines. Password based authentication will be disabled by default and enabling it so password based auth can be done.

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Supressing the banner message everytime you connect to the vagrant box.

touch /home/vagrant/.hushlogin

# Updating the hosts file for all the 3 nodes with the IP given in vagrantfile

# 192.169.56.3 controller.mieweb.local controller
# 192.168.56.4 dhcpsrvr.mieweb.local dhcpsrvr
# 192.168.56.5 dhcpclient.mieweb.local dhcpclient

echo -e "192.168.56.3 controller.mieweb.local controller\n192.168.56.4 dhcpsrvr.mieweb.local dhcpsrvr\n192.168.56.5 dhcpclient.mieweb.local dhcpclient" >> /etc/hosts

# Installing necessary packages 

sudo apt update && sudo apt -y install curl wget net-tools iputils-ping python3-pip sshpass

# Install ansible using pip only in controller node

if [[ $(hostname) = "controller" ]]; then
  sudo pip3 install ansible
fi

