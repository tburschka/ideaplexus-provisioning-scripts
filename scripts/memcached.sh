#!/usr/bin/env bash

echo "memcached" >> /tmp/provisioning

apt-get -y install memcached
sed 's/^-m 64$/-m 512/' -i /etc/memcached.conf # increase memory size
sed 's/^\(-l 127.0.0.1\)$/# \1/' -i /etc/memcached.conf # don't listen to specific ip
service memcached restart
