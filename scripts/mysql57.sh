#!/usr/bin/env bash

echo "mysql" >> /tmp/provisioning

apt-key adv --keyserver pgp.mit.edu --recv-keys 5072E1F5
echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-5.7" | tee -a /etc/apt/sources.list.d/mysql.list
apt-get update

echo "mysql-community-server mysql-community-server/root-pass password root" | debconf-set-selections
echo "mysql-community-server mysql-community-server/re-root-pass password root" | debconf-set-selections
echo "mysql-community-server mysql-community-server/data-dir note" | debconf-set-selections
apt-get -y install mysql-community-server mysql-community-client

# don't listen to specific ip
sed 's/^\(bind-address\s*= 127.0.0.1\)$/# \1/' -i /etc/mysql/mysql.conf.d/mysqld.cnf

# set default collation and character set
echo "collation_server=utf8_general_ci" >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo "character_set_server=utf8" >> /etc/mysql/mysql.conf.d/mysqld.cnf

# allow root user from everywhere
mysql -uroot -proot -e "CREATE USER 'root'@'%' IDENTIFIED BY 'root'; flush privileges; GRANT ALL PRIVILEGES ON * . * TO 'root'@'%';"
service mysql restart
