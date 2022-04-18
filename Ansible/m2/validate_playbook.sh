#!/bin/bash

echo "### Validating the playbook.yml syntax..."
ansible-playbook playbook.yml --syntax-check

echo "### Check which host/s will be affected with..."
ansible-playbook playbook.yml --list-hosts
