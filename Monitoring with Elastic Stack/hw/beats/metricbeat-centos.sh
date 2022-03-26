#!/bin/bash

echo "⠿⠿ Installing metricbeat..."
wget https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-8.1.0-x86_64.rpm
sudo rpm -Uvh metricbeat-8.1.0-x86_64.rpm
