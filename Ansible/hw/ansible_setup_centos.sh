#!/bin/bash

echo "### Installing Ansible for Red Hat/CentOS..."
sudo dnf install -y epel-release
sudo dnf install -y ansible

echo "### Explore ansible"
ansible --version
rpm -qc ansible

echo "### Checking Ansible global inventory file..."
sudo cat /etc/ansible/hosts
