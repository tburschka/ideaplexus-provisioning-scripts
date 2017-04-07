#!/usr/bin/env bash

echo "common-packages" >> /tmp/provisioning

apt-get -y install \
    build-essential \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    curl
