#!/bin/bash

echo Configuring cluster
/bin/sed --in-place --expression 's/#cluster.name: elasticsearch/cluster.name: logstash/g' /etc/elasticsearch/elasticsearch.yml 

echo Configuring node
/bin/sed --in-place --expression 's/#node.name: "Franz Kafka"/node.name: "logstash"/g' /etc/elasticsearch/elasticsearch.yml 
