#!/usr/bin/env bash

# Remove APT cache
apt-get -y autoremove
apt-get -y clean
apt-get -y autoclean

# Remove apt indices
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/apt/*

# Remove documentation
rm -rf /usr/share/locale/*
rm -rf /usr/share/doc/*

# Zero free space to aid VM compression
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Remove bash history
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history

# Cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# Cleanup tmp files
find /tmp -type f | while read f; do rm -f; done;

# Whiteout root
count=`df --sync -kP / | tail -n1 | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count;
rm /tmp/whitespace;

# Whiteout /boot
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace;

#swappart=$(cat /proc/swaps | grep -v Filename | tail -n1 | awk -F ' ' '{print $1}')
#if [ "$swappart" != "" ]; then
#  swapoff $swappart;
#  dd if=/dev/zero of=$swappart;
#  mkswap $swappart;
#  swapon $swappart;
#fi