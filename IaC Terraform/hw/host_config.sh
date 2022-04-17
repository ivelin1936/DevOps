#!/bin/bash

echo "## Add hosts ..."
echo "192.168.56.11 docker.hw.tf docker" >> /etc/hosts

echo "* Install Additional Packages ..."
sudo dnf install -y jq tree git nano sshpass
sudo yum install -y lsof net-tools