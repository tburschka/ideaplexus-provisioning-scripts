#!/usr/bin/env bash

echo "ntp" >> /tmp/provisioning

apt-get -y install ntp

if grep -q "debian" "/tmp/provisioning"; then
  sed 's/debian.pool.ntp.org/de.pool.ntp.org/' -i "/etc/ntp.conf"
  crontab -u vagrant -l > /tmp/crons
  echo "@reboot /usr/sbin/ntpd -gq" >> /tmp/crons
  echo "0 * * * * /usr/sbin/ntpd -gq" >> /tmp/crons
  echo "" >> /tmp/crons
  crontab -u vagrant /tmp/crons
  rm /tmp/crons
fi

if grep -q "ubuntu" "/tmp/provisioning"; then
  sed 's/ubuntu.pool.ntp.org$/de.pool.ntp.org/' -i "/etc/ntp.conf"
  sed 's/ntp.ubuntu.com$/pool.ntp.org/' -i "/etc/ntp.conf"
  crontab -u root -l > /tmp/crons
  echo "@reboot /usr/sbin/ntpdate -u de.pool.ntp.org pool.ntp.org" >> /tmp/crons
  echo "0 * * * * /usr/sbin/ntpdate -u de.pool.ntp.org pool.ntp.org" >> /tmp/crons
  echo "" >> /tmp/crons
  crontab -u root /tmp/crons
  rm /tmp/crons
fi