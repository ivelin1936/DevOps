#!/bin/bash
 
if [ "$(systemctl is-active docker)" != "active" ]; then 
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
            echo "Restart docker ($counter)....."
            sudo systemctl restart docker
            fi
        fi
    done
fi
 
echo "### Deploying prometheus stack...."
sudo docker-compose -f docker-compose.yaml down || true
sudo docker-compose build --no-cache 
sudo docker-compose -f docker-compose.yaml up -d 
