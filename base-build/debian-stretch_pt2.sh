#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

echo "APT::Get::Assume-Yes \"true\";" | tee /etc/apt/apt.conf.d/10-assume_yes
sleep 1
echo "setting certs for wget"
--ca-directory=/usr/ssl/certs
sleep 1
# echo "Installing git."
# sleep 1
# apt-get install --no-install-recommends git
# sleep 1
echo "Removeing unnecessary packages."
sleep 1
apt-get remove --allow-remove-essential e2fsprogs e2fslibs pinentry-curses whiptail kmod iptables iproute2 dmidecode
sleep 1
echo "cleanup"
sleep 1
apt-get clean
sleep 1
find /var/lib/apt/lists/ -maxdepth 2 -type f -delete
sleep 1
echo "Type "exit" go back to root for final steps."
sleep 1
exec ./debian-stretch_pt3.sh
exit
