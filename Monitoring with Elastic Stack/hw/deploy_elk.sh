#!/bin/bash

HOSTNAME_IP=$(hostname -i | awk '{print $2}')
echo "⠿⠿ Deploying ELK on host $HOSTNAME_IP..."

echo "⠿ System limits on mmap counts: "
sudo sysctl vm.max_map_count
echo "⠿ Increasing it to 262144"
sudo sysctl -w vm.max_map_count=262144

SHARED_FOLDER=${PWD}/elk
DOCKER_COMPOSE_FILE=docker-compose.yml
test -f $SHARED_FOLDER/$DOCKER_COMPOSE_FILE || DOCKER_COMPOSE_FILE=docker-compose.yaml

if [ -f $SHARED_FOLDER/$DOCKER_COMPOSE_FILE ]; then
    echo "⠿ '$DOCKER_COMPOSE_FILE' file found... Testing the compose file::.."
    docker-compose -f $SHARED_FOLDER/$DOCKER_COMPOSE_FILE config
    
    echo "⠿ Deploying ELK..."
#     cp $SHARED_FOLDER/$DOCKER_COMPOSE_FILE . && sudo chown vagrant:vagrant $DOCKER_COMPOSE_FILE
    docker-compose -f $SHARED_FOLDER/$DOCKER_COMPOSE_FILE up -d

    [ -z "$HOSTNAME_IP" ] && HOSTNAME_IP=$(hostname -i | awk '{print $1}')
    echo "⠿ ELK deployed sucessfully! You can check Kibana on http://$HOSTNAME_IP:5601"
else 
    echo "⠿ There is no docker compose yaml file found at destination '$SHARED_FOLDER/$DOCKER_COMPOSE_FILE'...."
fi
