#!/bin/bash

echo "### Setup Ansible hosts for practice..."
sudo echo "[srv]" > /etc/ansible/hosts
sudo echo "192.168.56.10" >> /etc/ansible/hosts
sudo echo "192.168.56.11" >> /etc/ansible/hosts

sudo echo "" >> /etc/ansible/hosts

sudo echo "[clnt]" >> /etc/ansible/hosts
sudo echo "192.168.56.12" >> /etc/ansible/hosts

echo "### Checking the new Ansible global inventory file settings..."
sudo cat /etc/ansible/hosts

