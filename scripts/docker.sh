#!/usr/bin/env bash

echo "docker" >> /tmp/provisioning

if grep -q "ubuntu" "/tmp/provisioning"; then
    apt-get install \
        linux-image-extra-$(uname -r) \
        linux-image-extra-virtual

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"

fi

if grep -q "debian" "/tmp/provisioning"; then
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) \
       stable"
fi

apt-get update

apt-get -y install docker-ce

systemctl start docker