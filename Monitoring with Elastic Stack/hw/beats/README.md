#### The script's name have to be in format <BEAT_NAME>-<DISTRIBUTION>.sh

- Example: if we have for name 'hearbeat' and it's installation for 'centos', then the script name have to be 'hearbeat-centos.sh'
similar if the script is ubuntu installation, then the script's name have to be 'hearbeat-ubuntu.sh'

#### The beat's setup should be placed into script with name <BEAT_NAME>-setup.sh
    - Example: 'metricbeat-setup.sh'
    
##### Script should contains:
    - Enable/disable needed modules (example: `sudo metricbeat modules enable system`)
    - Install the beat's template into the Elasticsearch (example: `sudo metricbeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["192.168.56.11:9200"]'`)
    - Start and enable the beat service (example: `sudo systemctl daemon-reload, sudo systemctl enable metricbeat, sudo systemctl start metricbeat`)

#### Check and change, if need there is need too, the ELASTICSEARCH_HOST value in all setup scripts (<BEAT_NAME>-setup.sh) to fit your specific case!!!
