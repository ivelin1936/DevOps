#!/bin/bash
 
echo "### Deploying prometheus stack...."
docker-compose -f docker-compose.yaml down || true
docker-compose build --no-cache 
docker-compose -f docker-compose.yaml up -d 
