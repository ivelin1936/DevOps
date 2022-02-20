#!/bin/bash

echo "* Add hosts ..."
echo "192.168.56.11 docker1.ex.ivo docker1" >> /etc/hosts
echo "192.168.56.12 docker2.ex.ivo docker2" >> /etc/hosts
echo "192.168.56.13 docker3.ex.ivo docker3" >> /etc/hosts

echo "* Install Additional Packages ..."
sudo dnf install -y jq tree git nano

#echo "### Disable the firewall"
#sudo systemctl disable --now firewalld
# OR
echo "### Open ports: Firewall - swarm!2377/tcp for cluster management communications, 7946/tcp and 7946/udp for communication among nodes and 4789/udp for overlay network traffic."
sudo firewall-cmd --add-port=2377/tcp --permanent
sudo firewall-cmd --add-port=4789/udp --permanent
sudo firewall-cmd --add-port=7946/tcp --permanent
sudo firewall-cmd --add-port=7946/udp --permanent

echo "### Firewall - open port 8080 ..."
# sudo systemctl start firewalld
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
