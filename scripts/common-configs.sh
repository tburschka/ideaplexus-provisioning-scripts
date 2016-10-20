#!/usr/bin/env bash

echo "common-configs" >> /tmp/provisioning

echo "fs.inotify.max_user_watches=16384" >> /etc/sysctl.conf
echo "Europe/Berlin" | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

if grep -q "debian" "/tmp/provisioning"; then
  echo 1 | select-editor
fi

if grep -q "ubuntu" "/tmp/provisioning"; then
  echo 2 | select-editor
fi