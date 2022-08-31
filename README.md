# Ansible Lab

## Challenge
---
Deploy a Vagrant/VirtualBox solution to automate deploying a Linux based DHCP server.

Requirements:
- Solution needs to leverage open-source technologies
- Provisioning needs to be automated
- The DHCP client needs to leverage [Netboot.xyz](https://netboot.xyz/) via a private network

Prerequisites: (This solution was tested on Debian 11)
- Internet Connection
- Hardware: VT-x/AMD-V support needs to be enabled in BIOS
- [Vagrant[](https://learn.hashicorp.com/tutorials/vagrant/getting-started-index)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Terminal

## The lab environment
---
| Name | Description | Private IP |
|:-----|:------------|:-----------|
| controller | Ansible Controller | 192.168.56.3 |
| dhcpsrvr | DHCP / NAT Server | 192.168.56.4 |
| dhcpclient | DHCP Client | 192.168.56.5 |

## Deploy your lab environment
---
First, clone the code from the [GitHub repo](https://github.com/jonalarson/vagrant-ansible-lab):

```bash
git clone https://github.com/jonalarson/vagrant-ansible-lab
cd vagrant-ansible-lab
vagrant up
```

Verify that all VMs are running:

```bash
vagrant status
```

This should return:

```bash
controller                running (virtualbox)
dhcpsrvr                  running (virtualbox)
dhcpclient                running (virtualbox)
```

Setup SSH Key Authentication and deploy the DHCP/NAT server

```bash
vagrant ssh controller
make setup-ssh
make deploy-dhcp-srvr
```

Release and renew the DHCP on the dhcp client

```bash
make run-dhcpclient
```

This should return the DHCP lease from the dhcpsrvr

```bash
MAC                IP              hostname  
=============================================
08:00:27:72:1a:ba  192.168.56.10   dhcpclient     
```

## Create a new VM to boot Netboot.xyz
---

1. Download a [Netboot.xyz ISO](https://boot.netboot.xyz/ipxe/netboot.xyz.iso)
2. Launch VirtualBox
3. Add a new virtual machine
   1. Name: Netboot.xyz
   2. Type: Linux
4. Select "Install from disc or image"
5. Select Linux 2.6 / 3.x / 4.x (64-bit)
6. Select -> Next -> Create -> Next -> Next -> Create

Next you'll need to configure the VM to boot from the Netboot.iso 

1. Select the VM from the previous step 
2. Select _Settings_ -> _Storage_
   1. Select the _CD_ -> Select _Live CD/DVD_
   2. Select the _CD Icon_ -> Select the _Netboot.xyz ISO file_ navigate to the file from the previous step
3. Select Network
   1. Change Adapter 1 from _NAT_ to _Host-only Adapter_ -> Select _vboxnet1_ -> _Ok_
4. Start the VM