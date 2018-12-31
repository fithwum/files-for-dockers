#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

DISTRO=
RELEASE=

echo "Getting needed things"
apt-get install -y debootstrap ftp-upload bash dirmngr
sleep 1
echo "Downloading distro of choice"
debootstrap --keyring /etc/apt/trusted.gpg.d/debian-archive-stretch-stable.gpg --force-check-gpg --variant=minbase --components=main,contrib,non-free --include=dirmngr,apt-transport-https,wget,bzip2 --arch=amd64 stable /debian-stretch http://deb.debian.org/debian/
sleep 1
du --human-readable --summarize debian-stretch
sleep 10
echo "Mounting folders for root"
mount --bind /dev debian-stretch/dev
sleep 0.5
mount --bind /dev/pts debian-stretch/dev
sleep 0.5
mount --bind /proc debian-stretch/proc
sleep 0.5
mount --bind /sys debian-stretch/sys
sleep 5
echo "Changine to new root"
sudo chroot debian-stretch
exit
