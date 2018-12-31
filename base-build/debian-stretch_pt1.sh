#!/bin
# Copyright (c) 2018 fithwum
# All rights reserved

RELEASE=stable

echo "Getting needed things"
wget https://raw.githubusercontent.com/fithwum/files-for-dockers/master/base-build/debian-stretch_pt3.sh
apt-get install -y debootstrap ftp-upload bash dirmngr
sleep 1
echo "Downloading distro of choice"
debootstrap --keyring /etc/apt/trusted.gpg.d/debian-archive-stretch-stable.gpg --force-check-gpg --variant=minbase --components=main,contrib,non-free --include=dirmngr,apt-transport-https,wget,bzip2 --arch=amd64 stable /debian-stretch http://deb.debian.org/debian/
sleep 1
du --human-readable --summarize debian-stretch
wget https://raw.githubusercontent.com/fithwum/files-for-dockers/master/base-build/debian-stretch_pt2.sh /debian-stretch/debian-stretch_pt2.sh
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
