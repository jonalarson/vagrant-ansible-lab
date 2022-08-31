SHELL:=/bin/bash

.PHONY: setup-ssh
setup-ssh: ## setup ssh keys
	bash key_gen.sh

.PHONY: deploy-dhcpsrvr
deploy-dhcpsrvr: ## provision ansible playbook
	ansible-playbook -i ansible_project/inventory /vagrant/dhcpsrvr.yml

.PHONY: run-dhcpclient
run-dhcpclient: ## run a dhcp release/renew dhcpclient
	ansible -i ansible_project/inventory dhcpclient -a "sudo dhclient enp0s8"
	ansible -i ansible_project/inventory dhcpsrvr -a "dhcp-lease-list"