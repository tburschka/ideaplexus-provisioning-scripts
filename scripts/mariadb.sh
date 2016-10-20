#!/usr/bin/env bash

echo "mysql" >> /tmp/provisioning
echo "mariadb" >> /tmp/provisioning

apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
add-apt-repository 'deb [arch=amd64,i386] http://ftp.hosteurope.de/mirror/mariadb.org/repo/10.1/debian jessie main'
apt-get update

echo "mariadb-server-10.1 mysql-server/root_password password root" | debconf-set-selections
echo "mariadb-server-10.1 mysql-server/root_password_again password root" | debconf-set-selections

apt-get -y install mariadb-server mariadb-client

sed 's/^\(bind-address.*=.*\)$/#\1/' -i /etc/mysql/my.cnf
sed 's/^\(max_connections.*=\).*$/\1 1000/' -i /etc/mysql/my.cnf
sed 's/^#\(innodb_log_file_size.*=\).*$/\1 1G/' -i /etc/mysql/my.cnf
sed 's/^\(innodb_buffer_pool_size.*=\).*$/\1 4G/' -i /etc/mysql/my.cnf
sed 's/^\(innodb_flush_method.*= O_DIRECT\)$/\1\ncollation_server        = utf8_general_ci\ncharacter_set_server    = utf8/' -i /etc/mysql/my.cnf

mysql -uroot -proot -e "CREATE USER 'root'@'%' IDENTIFIED BY 'root'; flush privileges; GRANT ALL PRIVILEGES ON * . * TO 'root'@'%';"