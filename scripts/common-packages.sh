#!/usr/bin/env bash

echo "common-packages" >> /tmp/provisioning

apt-get -y install ca-certificates build-essential software-properties-common
