#!/usr/bin/env bash
apt-get -y install mongodb
sed 's/^\(bind_ip = 127.0.0.1\)$/#\1/' -i /etc/mongodb.conf # don't listen to specific ip
