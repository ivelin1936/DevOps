#!/bin/bash

echo "* Add hosts ..."
echo "192.168.56.11 jenkins.m5.hw jenkins" >> /etc/hosts
echo "192.168.56.12 docker.m5.hw docker" >> /etc/hosts

echo "* Install Additional Packages ..."
sudo dnf install -y jq tree git nano sshpass
