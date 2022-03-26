#!/bin/bash

echo "### Installing metricbeat..."
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.1.0-amd64.deb
sudo dpkg -i filebeat-8.1.0-amd64.deb

#TODO:
# Now that we have it installed, we must configure it
# Open the main configuration file
# sudo vi /etc/filebeat/filebeat.yml
# Change the following
# Disable the Elasticsearch output (line #132) and enable the Logstash output (line #145)
# Don’t forget to substitute the localhost with the IP of the Logstash server (192.168.99.101)
# Save and close the file
# Test the configuration with
# sudo filebeat test config
# To check what modules are available, you can either
# ls -al /etc/filebeat/modules.d
# Or execute the following
# sudo filebeat modules list
# If no module is enabled, we can enable the system module with (do not do it)
# sudo filebeat modules enable system
# We will continue with the default module configured
# Reopen the main configuration file 
# sudo vi /etc/filebeat/filebeat.yml
# and add an input (around line #50)
# - type: filestream
#   enabled: true
#   paths:
#     - /tmp/app.log
# Save and close the file
# Execute the following to generate a few messages in the monitored log file
# for i in $(seq 1 10); do echo "$(date) -> test message #$i" >> /tmp/app.log; sleep 3; done
# Install the beat’s template in Elasticsearch
# sudo filebeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["192.168.99.101:9200"]'
# Start and enable the Filebeat service
# sudo systemctl daemon-reload
# sudo systemctl enable filebeat
# sudo systemctl start filebeat
# Go to Kibana UI, add the new data view (filebeat-*), and explore the messages
