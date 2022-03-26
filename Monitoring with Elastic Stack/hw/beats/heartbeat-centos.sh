#!/bin/bash

echo "### Installing metricbeat..."
wget https://artifacts.elastic.co/downloads/beats/heartbeat/heartbeat-8.1.0-x86_64.rpm
sudo rpm -Uvh heartbeat-8.1.0-x86_64.rpm

#TODO:
# Now that we have it installed, we must configure it
# Open the main configuration file
# sudo vi /etc/heartbeat/heartbeat.yml
# There is a default but disabled HTTP monitor
# So, just below its definition (around line 39), we can add the following
# - type: icmp
#   id: icmp-monitor
#   name: ICMP Monnitor
#   schedule: '*/30 * * * * * *'
#   hosts: ["192.168.56.11", "192.168.56.12", "192.168.56.13"]
# Then, we should disable the Elasticsearch output (around line #106) and enable the Logstash output (around line #119)
# Don’t worry about the 5044 port, we will deal with this in a bit
# Save and close the file
# Test the configuration with
# sudo heartbeat test config
# Install the beat’s template in Elasticsearch
# sudo heartbeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["localhost:9200"]'
# Go to /usr/share/logstash/bin and list all installed plugins
# ./logstash-plugin list
# Our plugin (logstash-input-beats) is listed, so we can create a configuration file
# sudo vi /etc/logstash/conf.d/beats.conf
# Enter the following and save
# input {
#   beats {
#     port => 5044
#   }
# }
# output {
#   elasticsearch {
#     hosts => ["http://localhost:9200"]
#     index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
#   }
# }
# Restart Logstash service
# sudo systemctl restart logstash
# Start and enable the Heartbeat service
# sudo systemctl daemon-reload
# sudo systemctl enable heartbeat-elastic
# sudo systemctl start heartbeat-elastic
# Go to Kibana UI, add the new data view (heartbeat-*), and explore the messages
# For example, open a message and check its details
# Or filter for the fields that starts with monitor
