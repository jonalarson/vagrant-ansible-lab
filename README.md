# Ansible Lab

## Challenge
---
Deploy a Vagrant/VirtualBox solution to automate deploying a Linux based DHCP server.

Requirements:
- Solution needs to leverage open-source technologies
- Provisioning needs to be automated
- The DHCP client needs to leverage [Netboot.xyz](https://netboot.xyz/) via a private network

Prerequisites: (This solution was tested on Ubuntu 20.04.4 LTS)
- Internet Connection
- Hardware: VT-x/AMD-V support needs to be enabled in BIOS
- [Vagrant](https://learn.hashicorp.com/tutorials/vagrant/getting-started-index)
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

To verify the DHCP is working run the command below to release/renew DHCP on the dhcpclient

```bash
make run-dhcpclient
```

This should return the DHCP lease from the dhcpsrvr

```bash
MAC                IP              hostname  
=============================================
08:00:27:72:1a:ba  192.168.56.10   dhcpclient     
```

## Create a new VM to PXE boot the Netboot.xyz distro from the DNS/DHCP/TFTP
---

1. Launch VirtualBox
2. Add a new virtual machine
   - Name: _Netboot.xyz_
   - Type: _Linux_
   - Version: _Linux 2.6 / 3.x / 4.x (64-bit)_
3. Configure the virtual machine hardware
   - Memory: _512_
   - Hard Disk: _Do not add a virtal hard disk_
4. Select the _Netboot.xyz_ and select _Settings_
   - Select _System_ 
      - Uncheck: Floppy
      - Uncheck: Optical
      - Uncheck: Hard Disk
      - Select: Network
   - Select _Network_
      - Change Adapter 1 from _NAT_ to _Host-only Adapter_
         - Name: Select _vboxnet1_
5. Start the virtual machine and follow the _Netboot.xyz_ prompts
