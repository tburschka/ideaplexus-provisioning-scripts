#!/usr/bin/env bash

if ! grep -q "nginx" "/tmp/provisioning"; then
  sh /provisioning/scripts/nginx.sh
fi

if ! grep -q "elasticsearch" "/tmp/provisioning"; then
  sh /provisioning/scripts/elasticsearch.sh
fi

echo "elasticsearch-hq" >> /tmp/provisioning

cd /usr/share/elasticsearch/bin
./plugin install royrusso/elasticsearch-HQ

cp /provisioning/files/elasticsearch-hq/elastic.conf /etc/nginx/sites-available/elastic.conf
ngx-conf -e elastic.conf
systemctl reload nginx