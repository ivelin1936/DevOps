#!/bin/bash

echo "### Ansible gathered info for host/s..."
ansible clnt -m setup

echo "### Check OS type of 'clnt' group..."
ansible clnt -m setup | grep ansible_os
