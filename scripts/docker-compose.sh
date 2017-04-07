#!/usr/bin/env bash

echo "docker-compose" >> /tmp/provisioning

VERSION=`curl -s https://api.github.com/repos/docker/compose/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4 | sed 's/[^0-9]*\([0-9.]*\).*/\1/'`

curl -L https://github.com/docker/compose/releases/download/$VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose