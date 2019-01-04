#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

RELEASE=stable
echo "getting system updates"
apt-get -y update
echo "Getting needed things"
wget --no-cache https://raw.githubusercontent.com/fithwum/files-for-dockers/master/base-build/debian-stretch_pt2.sh -O /debian-stretch_pt2.sh
wget --no-cache https://raw.githubusercontent.com/fithwum/files-for-dockers/master/base-build/debian-stretch_pt3.sh -O /debian-stretch_pt3.sh
chmod +x debian-stretch_pt2.sh debian-stretch_pt3.sh
sleep 1
apt-get install -y debootstrap ftp-upload bash dirmngr
sleep 1
echo "Downloading debian & selected packages"
sleep 1
debootstrap --keyring /etc/apt/trusted.gpg.d/debian-archive-stretch-stable.gpg --force-check-gpg --variant=minbase --components=main,contrib,non-free --include=dirmngr,apt-transport-https,wget,bzip2,bash,nano,ca-certificates --arch=amd64 stable /debian-stretch http://deb.debian.org/debian/
sleep 1
echo "Filesystem size uncompressed."
sleep 1
du --human-readable --summarize debian-stretch
sleep 10
echo "Mounting folders for root"
sleep 1
mount --bind /dev debian-stretch/dev
sleep 1
mount --bind /dev/pts debian-stretch/dev
sleep 1
mount --bind /proc debian-stretch/proc
sleep 1
mount --bind /sys debian-stretch/sys
sleep 1
cp -v debian-stretch_pt2.sh /debian-stretch
sleep 1
echo "Change to new root"
sleep 1
sudo chroot debian-stretch
exit
