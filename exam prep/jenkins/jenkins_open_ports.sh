#!/bin/bash

echo "### Firewall - open port 80/tcp, 8080/tcp and adding http and https services ..."
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

echo "### Check firewall and accessible ports:::"
sudo firewall-cmd --list-all
