#!/usr/bin/env bash

echo "redis" >> /tmp/provisioning

if ! grep -q "dotdeb" "/tmp/provisioning"; then
  sh /provisioning/scripts/dotdeb.sh
fi

apt-get -y install redis-server
sed 's/^\(bind 127.0.0.1\)$/# \1/' -i /etc/redis/redis.conf # don't listen to specific ip
