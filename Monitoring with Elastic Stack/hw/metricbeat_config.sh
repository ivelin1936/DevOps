#!/bin/bash

echo "### METRICBEAT CONFIG NOT IMPLEMENTED!!!!!!!"

#TODO:
# Now that we have it installed, we must configure it
# Open the main configuration file
# sudo vi /etc/metricbeat/metricbeat.yml
# Change the following
# Disable the Elasticsearch output (line #92) and enable the Logstash output (line #105)
# Don’t forget to substitute the localhost with the IP of the Logstash server (192.168.99.101)
# Save and close the file
# Test the configuration with
# sudo metricbeat test config
# To check what modules are available, you can either
# ls -al /etc/metricbeat/modules.d
# Or execute the following
# sudo metricbeat modules list
# Now, if we want to enable a module, we can execute
# sudo metricbeat modules enable system
# This one may be enabled by default
# Install the beat’s template in Elasticsearch
# sudo metricbeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["192.168.99.101:9200"]'
# Start and enable the Metricbeat service
# sudo systemctl daemon-reload
# sudo systemctl enable metricbeat
# sudo systemctl start metricbeat

# Repeat the same steps (without the template installation) on node 2 (node2) and check the results in Kibana UI
