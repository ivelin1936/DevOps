#!/bin/bash

ELASTICSEARCH_HOST="192.168.56.11:9200"

echo "⠿⠿ Check available modules..."
# ls -al /etc/metricbeat/modules.d
sudo metricbeat modules list

echo "⠿⠿ Enabling 'system' module..."
sudo metricbeat modules enable system

echo "⠿⠿ Installing the beat’s template in Elasticsearch..."
sudo metricbeat setup --index-management -E output.logstash.enabled=false -E "output.elasticsearch.hosts=[$ELASTICSEARCH_HOST]" | true

echo "⠿⠿ Start and enable the Metricbeat service..."
sudo systemctl daemon-reload
sudo systemctl enable metricbeat
sudo systemctl start metricbeat
