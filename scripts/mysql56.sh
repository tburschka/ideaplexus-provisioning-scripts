#!/usr/bin/env bash

# ubuntu

echo "mysql-server-5.6 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.6 mysql-server/root_password_again password root" | debconf-set-selections
apt-get -y install mysql-server-5.6 mysql-server-core-5.6 mysql-client-5.6 mysql-client-core-5.6
sed 's/^\(bind-address\s*= 127.0.0.1\)$/# \1/' -i /etc/mysql/my.cnf # don't listen to specific ip
sed 's/^\(# ssl-key=\/etc\/mysql\/server-key.pem\)$/\1\ninnodb_file_per_table\ncollation_server=utf8_general_ci\ncharacter_set_server=utf8/' -i /etc/mysql/my.cnf # set innodb_file_per_table, default collation and character set
mysql -uroot -proot -e "CREATE USER 'root'@'%' IDENTIFIED BY 'root'; flush privileges; GRANT ALL PRIVILEGES ON * . * TO 'root'@'%';" # allow root user from everywhere
service mysql restart

# [Warning] Using unique option prefix key_buffer instead of key_buffer_size is deprecated and will be removed in a future release. Please use the full name instead.
# [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
