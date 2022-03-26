#!/bin/bash

HOSTNAME_IP=$(hostname -i | awk '{print $2}')
echo "### Deploying ELK on host $HOSTNAME_IP..."

SHARED_FOLDER=/elk
DOCKER_COMPOSE_FILE=docker-compose.yml
test -f $SHARED_FOLDER/$DOCKER_COMPOSE_FILE || DOCKER_COMPOSE_FILE=docker-compose.yaml

if [ -f $SHARED_FOLDER/$DOCKER_COMPOSE_FILE ]; then
    echo "::::: '$DOCKER_COMPOSE_FILE' file found... Deploying ELK..."
    cp $SHARED_FOLDER/$DOCKER_COMPOSE_FILE . && sudo chown vagrant:vagrant $DOCKER_COMPOSE_FILE
    docker compose up -d

    [ -z "$HOSTNAME_IP" ] && HOSTNAME_IP=$(hostname -i | awk '{print $1}')
    echo "ELK deployed sucessfully! You can check Elasticserch: http://$HOSTNAME_IP:9200, Kibana: http://$HOSTNAME_IP:5601"
else 
    echo "There is no docker compose yaml file found at destination '$SHARED_FOLDER/$DOCKER_COMPOSE_FILE'...."
fi
