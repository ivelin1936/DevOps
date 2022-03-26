#!/bin/bash

echo "### Installing metricbeat..."
wget https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-8.1.0-amd64.deb
sudo dpkg -i metricbeat-8.1.0-amd64.deb
