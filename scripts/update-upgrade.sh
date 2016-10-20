#!/usr/bin/env bash

if grep -q "debian" "/tmp/provisioning"; then
  apt-get update
  apt-get -y dist-upgrade
fi

if grep -q "ubuntu" "/tmp/provisioning"; then
  apt-get update
  apt-get -yt $(lsb_release -cs)-security dist-upgrade
  apt-get -y dist-upgrade
fi
