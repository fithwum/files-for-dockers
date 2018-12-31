#!/bin
# Copyright (c) 2018 fithwum
# All rights reserved
echo "APT::Get::Assume-Yes \"true\";" | tee /etc/apt/apt.conf.d/10-assume_yes
sleep 2
apt-get install --no-install-recommends git
sleep 2
apt-get remove --allow-remove-essential e2fsprogs e2fslibs pinentry-curses whiptail kmod iptables iproute2 dmidecode
sleep 2
apt-get clean
sleep 2
find /var/lib/apt/lists/ -maxdepth 2 -type f -delete
sleep 2
exit
