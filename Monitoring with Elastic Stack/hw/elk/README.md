#### Development/Test env
- You dont need to change nothing inside.

#### Production env
- Have to enable `xpack.security` into the `elasticsearch.yaml` config file
- Chnage passwords for stack users into `.env` file
- In case of activated security
    - Implement and run once a service into the docker-compose.yml for initializes the 'logstash_internal' and 'kibana_system' users inside Elasticsearch with the values of the passwords defined in the `.env` file. The task should be only performed during the *initial* startup of the stack! For help/tips, please check [docker-elk](https://github.com/deviantony/docker-elk)


#### Logstash pipline 
- Defined into `logstash.conf`, should be changed/extended in about of needs!


###### Resources:
- [Elasticserch Settings](https://www.elastic.co/guide/en/elasticsearch/reference/current/settings.html)
- [Configure Kibana](https://www.elastic.co/guide/en/kibana/8.1/settings.html#server-publicBaseUrl)
- [Logstash Setup](https://www.elastic.co/guide/en/logstash/current/setup-logstash.html)
