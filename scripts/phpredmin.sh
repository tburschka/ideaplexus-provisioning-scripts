#!/usr/bin/env bash

if ! grep -q "nginx" "/tmp/provisioning"; then
  sh /provisioning/scripts/nginx.sh
fi

if ! grep -q "php" "/tmp/provisioning"; then
  sh /provisioning/scripts/php-7.sh
fi

if ! grep -q "redis" "/tmp/provisioning"; then
  sh /provisioning/scripts/redis.sh
fi

echo "phpredmin" >> /tmp/provisioning

cd /var
git clone https://github.com/sasanrose/phpredmin.git
mkdir -p phpredmin/logs
sed 's/Amsterdam$/Berlin/' -i /var/phpredmin/config.dist.php
chown -R vagrant:vagrant /var/phpredmin

crontab -l | { cat; echo "* * * * * cd /var/phpredmin/public && php index.php cron/index"; } | crontab -

cp /provisioning/files/phpredmin/redis.conf /etc/nginx/sites-available/redis.conf
ngx-conf -e redis.conf
systemctl reload nginx