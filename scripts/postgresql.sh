#!/usr/bin/env bash

echo "postgresql" >> /tmp/provisioning

# @see http://trac.osgeo.org/postgis/wiki/UsersWikiPostGIS22UbuntuPGSQL95Apt

echo "deb http://apt.postgresql.org/pub/repos/apt trusty-pgdg main" | tee -a /etc/apt/sources.list.d/postgresql.list
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
apt-get update

apt-get -y install postgresql-9.5-postgis-2.2 postgresql-contrib-9.5

# allow any connection
echo "host all all 0.0.0.0/0 trust" >> etc/postgresql/9.5/main/pg_hba.conf
echo "listen_addresses = '*'" >> /etc/postgresql/9.5/main/postgresql.conf

service postgresql restart
