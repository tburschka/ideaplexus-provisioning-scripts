#!/usr/bin/env bash

echo "elasticsearch" >> /tmp/provisioning

echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
apt-get update

apt-get -y install elasticsearch
systemctl daemon-reload
systemctl enable elasticsearch.service

echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml