#!/usr/bin/env bash

echo "locale" >> /tmp/provisioning

sed "s/\(en_US\)/de_DE/" -i "/etc/default/locale"
sed "s/^\# \(de_DE.*\)$/\1/" -i "/etc/locale.gen"
locale-gen
echo "LC_ALL=de_DE.UTF-8" > "/etc/environment"