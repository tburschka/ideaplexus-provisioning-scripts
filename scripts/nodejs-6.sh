#!/usr/bin/env bash

echo "nodejs" >> /tmp/provisioning

apt-get -y --purge remove node
wget -q -O - https://deb.nodesource.com/setup_6.x | bash -
apt-get -y install nodejs