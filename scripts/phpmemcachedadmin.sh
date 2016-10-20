#!/usr/bin/env bash

if ! grep -q "nginx" "/tmp/provisioning"; then
  sh /provisioning/scripts/nginx.sh
fi

if ! grep -q "php" "/tmp/provisioning"; then
  sh /provisioning/scripts/php-7.sh
fi

if ! grep -q "memcached" "/tmp/provisioning"; then
  sh /provisioning/scripts/memcached.sh
fi

echo "phpmemcachedadmin" >> /tmp/provisioning

wget -q -O /tmp/phpmemcachedadmin.tgz https://github.com/tburschka/phpmemcachedadmin/archive/1.2.2.tar.gz
tar xzf /tmp/phpmemcachedadmin.tgz -C /var
mv /var/phpmemcachedadmin-1.2.2 /var/phpmemcachedadmin
chown -R  vagrant:vagrant /var/phpmemcachedadmin
sed 's/Europe\/Paris/Europe\/Berlin/' -i "/var/phpmemcachedadmin/configure.php"
rm -f /tmp/phpmemcachedadmin.tgz

cp /provisioning/files/phpmemcachedadmin/memcached.conf /etc/nginx/sites-available/memcached.conf

ngx-conf -e memcached.conf
systemctl reload nginx