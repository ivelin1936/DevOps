#!/bin/bash

echo "### Installing Ansible for Debian/Ubuntu..."
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

echo "### Explore ansible"
ansible --version
sudo cat /var/lib/dpkg/info/ansible.conffiles

echo "### Checking Ansible global inventory file..."
sudo cat /etc/ansible/hosts
