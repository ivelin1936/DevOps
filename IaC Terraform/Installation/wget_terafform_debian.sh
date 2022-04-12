#!/bin/bash

echo '### Installing terraform...'
wget https://releases.hashicorp.com/terraform/1.1.7/terraform_1.1.7_linux_amd64.zip -O /tmp/terraform.zip
unzip /tmp/terraform.zip -d /tmp
sudo mv /tmp/terraform /usr/local/bin

echo '### Testing the installation...'
terraform version

echo '### Supported commands:'
terraform
echo '### Commands help can be seen by terraform -help [command]'
