#!/bin/bash

echo "### Deploying the infrastructure..."
vagrant up --no-provision ans web1 db clnt
