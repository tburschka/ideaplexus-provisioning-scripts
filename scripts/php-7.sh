#!/usr/bin/env bash

if ! grep -q "dotdeb" "/tmp/provisioning"; then
  sh /provisioning/scripts/dotdeb.sh
fi

apt-get -y install php7.0-apcu php7.0-apcu-bc php7.0-bcmath php7.0-bz2 php7.0-cli php7.0-common php7.0-curl php7.0-fpm php7.0-gd php7.0-geoip php7.0-igbinary php7.0-imagick php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-memcached php7.0-mysql php7.0-opcache php7.0-pgsql php7.0-readline hp7.0-redis php7.0-soap php7.0-sqlite3 php7.0-ssh2 php7.0-xdebug php7.0-xml php7.0-xmlrpc php7.0-xsl php7.0-zip

if ! grep -q "nginx" "/tmp/provisioning"; then
  sh /provisioning/scripts/nginx.sh
fi

echo "php" >> /tmp/provisioning
echo "php7" >> /tmp/provisioning

cp /provisioning/files/nginx/php7-fpm /etc/nginx/php7-fpm
rm -f /etc/nginx/php-fpm
ln -s /etc/nginx/php7-fpm /etc/nginx/php-fpm

sed 's/^;date.timezone =$/date.timezone = Europe\/Berlin/' -i "/etc/php/7.0/cli/php.ini"
sed 's/^\(post_max_size =\) 8M$/\1 64M/' -i "/etc/php/7.0/cli/php.ini"
sed 's/^\(upload_max_filesize =\) 2M$/\1 64M/' -i "/etc/php/7.0/cli/php.ini"
sed 's/^\(expose_php =\) On$/\1 Off/' -i "/etc/php/7.0/cli/php.ini"

sed 's/^;date.timezone =$/date.timezone = Europe\/Berlin/' -i "/etc/php/7.0/fpm/php.ini"
sed 's/^\(post_max_size =\) 8M$/\1 64M/' -i "/etc/php/7.0/fpm/php.ini"
sed 's/^\(upload_max_filesize =\) 2M$/\1 64M/' -i "/etc/php/7.0/fpm/php.ini"
sed 's/^\(expose_php =\) On$/\1 Off/' -i "/etc/php/7.0/fpm/php.ini"

sed 's/^\(\s*user =\) www-data$/\1 vagrant/' -i "/etc/php/7.0/fpm/pool.d/www.conf"
sed 's/^\(\s*group =\) www-data$/\1 vagrant/' -i "/etc/php/7.0/fpm/pool.d/www.conf"
