#!/bin/bash

echo "### Update repositories and install common packages"
apt-get update
apt-get install apt-transport-https ca-certificates curl software-properties-common

echo "### Add the GPG key for the official Docker repository to your system"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "### Add Docker repository"
# ID=${awk -F= '$1=="ID" { print $2 ;}' /etc/os-release}
ID=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')
VERSION=$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"')

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/$ID $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Make sure you are about to install from the Docker repo instead of the default Ubuntu repo"
apt-cache policy docker-ce

echo "* Install Docker"
apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

echo "* Adjust group membership"
usermod -aG docker vagrant
