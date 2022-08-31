SHELL:=/bin/bash

.PHONY: setup-ssh
setup-ssh: ## setup ssh keys
	bash key_gen.sh
