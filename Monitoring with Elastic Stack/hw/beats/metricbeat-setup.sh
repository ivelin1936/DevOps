#!/bin/bash

echo "⠿⠿ Check available modules..."
# ls -al /etc/metricbeat/modules.d
sudo metricbeat modules list

echo "⠿⠿ Enabling 'system' module..."
sudo metricbeat modules enable system

echo "⠿⠿ Installing the beat’s template in Elasticsearch..."
sudo metricbeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["192.168.99.101:9200"]' | true

echo "⠿⠿ Start and enable the Metricbeat service..."
sudo systemctl daemon-reload
sudo systemctl enable metricbeat
sudo systemctl start metricbeat
