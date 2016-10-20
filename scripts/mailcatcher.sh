#!/usr/bin/env bash

if ! grep -q "ruby" "/tmp/provisioning"; then
  sh /provisioning/scripts/ruby.sh
fi

echo "mailcatcher" >> /tmp/provisioning

apt-get -y install libsqlite3-dev g++
gem install --no-user-install --no-rdoc --no-ri mailcatcher

if grep -q "debian" "/tmp/provisioning"; then
  cp /provisioning/files/mailcatcher/mailcatcher.service /lib/systemd/system/mailcatcher.service

  systemctl daemon-reload
  systemctl start mailcatcher
  systemctl enable mailcatcher

  cp /provisioning/files/mailcatcher/mail.conf /etc/nginx/sites-available/mail.conf
  ngx-conf -e mail.conf
  systemctl reload nginx
fi

if grep -q "ubuntu" "/tmp/provisioning"; then
  cp /provisioning/files/mailcatcher/mailcatcher.conf /etc/init/mailcatcher.conf

  service mailcatcher start
  echo "sendmail_path = /usr/bin/env $(which catchmail)" | tee /etc/php5/mods-available/mailcatcher.ini
  php5enmod mailcatcher

  PKG_OK=$(dpkg-query -W --showformat='${Status}\n' php5-fpm|grep "install ok installed")
  if [ "" != "$PKG_OK" ]; then
      service php5-fpm restart
  fi
fi