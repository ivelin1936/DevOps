#!/bin/bash

echo "### Setup Ansible hosts..."
sudo echo "[srv]" > /etc/ansible/hosts
sudo echo "192.168.56.11" >> /etc/ansible/hosts
sudo echo "192.168.56.12" >> /etc/ansible/hosts

# sudo echo "" >> /etc/ansible/hosts

# sudo echo "[db]" >> /etc/ansible/hosts
# sudo echo "192.168.56.12" >> /etc/ansible/hosts

echo "### Checking the new Ansible global inventory file settings..."
sudo cat /etc/ansible/hosts

