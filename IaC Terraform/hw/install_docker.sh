#!/bin/bash

echo "## Removing oldest docker installations if there are any..."
sudo apt-get remove docker docker-engine docker.io containerd runc || true

echo "## Update repositories and install common packages..."
apt-get update && apt-get install -y ca-certificates curl gnupg lsb-release

echo "## Add Docker repository and key ..."
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "## Installing Docker ..."
apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

echo "## Add vagrant user to docker group ..."
usermod -aG docker vagrant

echo "## Adjust Docker configuration ..."
sed -i 's@-H fd://@-H fd:// -H tcp://0.0.0.0@g' /lib/systemd/system/docker.service

echo "## Restart Docker ..."
systemctl daemon-reload
counter=0
sudo systemctl restart docker
echo "### Checking docker deamon status..."
while true ; do
    sleep 5
    if [ "$(systemctl is-active docker)" = "active" ]; then 
        echo "Docker deamon is up! Checking status..."
        systemctl status docker
        break
    else
        counter=$((counter+1))
        if [ $((counter%2)) -eq 0 ]; then
        sudo systemctl restart docker
        fi
    fi
done
