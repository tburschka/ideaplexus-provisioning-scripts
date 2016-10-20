#!/usr/bin/env bash

echo "bundler" >> /tmp/provisioning

if ! grep -q "ruby" "/tmp/provisioning"; then
  sh /provisioning/scripts/ruby.sh
fi

gem install --no-user-install --no-rdoc --no-ri bundler
