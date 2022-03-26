#!/bin/bash

echo "⠿⠿ Installing metricbeat..."
wget https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-8.1.0-x86_64.rpm
sudo rpm -Uvh auditbeat-8.1.0-x86_64.rpm

#TODO:
# Now that we have it installed, we must configure it
# Open the main configuration file
# sudo vi /etc/auditbeat/auditbeat.yml
# Change the following
# Disable the Elasticsearch output (line #147) and enable the Logstash output (line #160)
# Don’t forget to substitute the localhost with the IP of the Logstash server (192.168.99.101)
# Save and close the file
# Test the configuration with
# sudo auditbeat test config
# Install the beat’s template in Elasticsearch
# sudo auditbeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["192.168.99.101:9200"]'
# Start and enable the Auditlbeat service
# sudo systemctl daemon-reload
# sudo systemctl enable auditbeat
# sudo systemctl start auditbeat
# Go to Kibana UI, add the new data view (auditbeat-*), and explore the messages
