#!/usr/bin/env bash

echo "dotdeb" >> /tmp/provisioning

add-apt-repository -s 'deb http://packages.dotdeb.org jessie all'
wget 'https://www.dotdeb.org/dotdeb.gpg'
apt-key add dotdeb.gpg
rm -f dotdeb.gpg
apt-get update