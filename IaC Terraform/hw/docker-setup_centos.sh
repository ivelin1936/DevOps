#!/bin/bash

echo "⠿⠿ Removing old Docker instance if there are any..."
sudo dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine || true

echo "⠿⠿ Adding Docker repository..."
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "⠿⠿ Install the packages (Java, git, Docker)..."
dnf update -y && dnf install -y java-11-openjdk git docker-ce docker-ce-cli containerd.io

echo "⠿⠿ Enable and Start Docker deamon and configuring it to start on boot..."
systemctl enable --now docker
systemctl start docker

echo "⠿⠿ Check Docker deamon status..."
sudo systemctl status docker
echo "⠿⠿ INFO:: Installed Docker Version: ..."
sudo docker version
echo "⠿⠿ INFO:: Installed Docker System Info: ..."
sudo docker system info

echo "⠿⠿ Adjust the group membership: Adding sudo user '$USER && vagrant' to the Docker group, to be able to work with docker without the need to use always sudo..."
usermod -aG docker $USER && usermod -aG docker vagrant

echo "## Adjust Docker configuration ..."
sudo sed -i 's@-H fd://@-H fd:// -H tcp://0.0.0.0@g' /lib/systemd/system/docker.service || true

sudo iptables -t filter -F
sudo iptables -t filter -X
counter=0
sudo systemctl daemon-reload
sudo systemctl restart docker
echo "⠿⠿ Checking docker deamon status..."
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






