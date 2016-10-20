#!/usr/bin/env bash

echo "ssh" >> /tmp/provisioning

# root
mkdir -p /root/.ssh
cp /provisioning/files/.ssh/config /root/.ssh
chmod 700 /root/.ssh

# vagrant
mkdir -p /home/vagrant/.ssh
cp /provisioning/files/.ssh/config /home/vagrant/.ssh
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
