#!/bin/bash

echo "### List all modules..."
ansible-doc -l

echo "### Fetch detailed information for the dnf module..."
ansible-doc dnf

echo "### Fetch sample module snippet..."
ansible-doc -s dnf
