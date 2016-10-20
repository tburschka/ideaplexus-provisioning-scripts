#!/usr/bin/env bash

echo "nginx" >> /tmp/provisioning

if ! grep -q "dotdeb" "/tmp/provisioning"; then
  sh /provisioning/scripts/dotdeb.sh
fi

apt-get -y install nginx-common nginx-extras

sed 's/^\(\s*sendfile\) on;$/\1 off;/' -i /etc/nginx/nginx.conf # disable sendfile due to a bug in vagrant
sed 's/^\(\s*user\) www-data;$/\1 vagrant vagrant;/' -i /etc/nginx/nginx.conf
gpasswd -a vagrant www-data
ngx-conf -d default #disable default profile
