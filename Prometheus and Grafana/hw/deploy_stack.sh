#!/bin/bash

DIR="/home/vagrant/prom"
[ -d "$DIR" ] && cd $DIR || echo "Shared dir '$DIR' not found"

FILE="deploy.sh"
[ -f "$FILE" ] && echo "::: Deploying...." && `./deploy.sh` || echo "File '$FILE' not found into dir '${pwd}'"
