#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

debootstrap --keyring /etc/apt/trusted.gpg.d/debian-archive-stretch-stable.gpg --force-check-gpg 
--variant=minbase --components=main,contrib,non-free --include=dirmngr,apt-transport-https,wget,bzip2 --arch=amd64 
stable debian-stretch http://deb.debian.org/debian/
sleep 5
du --human-readable --summarize debian-stretch
sleep 10
mount --bind /dev debian-stretch/dev
mount --bind /dev/pts debian-stretch/dev
mount --bind /proc debian-stretch/proc
mount --bind /sys debian-stretch/sys
sleep 2
sudo chroot debian-stretch

echo "APT::Get::Assume-Yes \"true\";" | tee /etc/apt/apt.conf.d/10-assume_yes

apt-get install --no-install-recommends git

apt-get remove --allow-remove-essential e2fsprogs e2fslibs nano 
pinentry-curses whiptail kmod iptables iproute2 dmidecode

apt-get clean

find /var/lib/apt/lists/ -maxdepth 2 -type f -delete

exit

umount debian-stretch/dev/pts
umount debian-stretch/dev
umount debian-stretch/proc
umount debian-stretch/sys

du --human-readable --summarize debian-stretch

tar --verbose --create --file debian-stretch.tar --directory debian-stretch .

sudo tar -cvjSf folder.tar.bz2 folder

ftp-upload -v -h 192.168.1.92:8001 -u {} --password {} -d /files debian-stretch.tar

sudo tar -cvjSf folder.tar.bz2 folder
