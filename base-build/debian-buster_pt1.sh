#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

RELEASE=stable

echo " "
echo "INFO ! Downloading other parts of the script if needed."
if [ -e /debian-buster_pt2.sh ]
	then
		echo "INFO ! debian-buster_pt2.sh found ... will not download."
	else
		echo " "
		echo "WARNING ! debian-buster_pt2.sh not found ... will download new copy."
			wget --no-cache https://raw.githubusercontent.com/fithwum/files-for-dockers/master/base-build/debian-buster_pt2.sh -O /debian-buster_pt2.sh
			chmod +x debian-buster_pt2.sh
fi
if [ -e /debian-buster_pt3.sh ]
	then
		echo "INFO ! debian-buster_pt3.sh found ... will not download."
	else
		echo " "
		echo "WARNING ! debian-buster_pt3.sh not found ... will download new copy."
			wget --no-cache https://raw.githubusercontent.com/fithwum/files-for-dockers/master/base-build/debian-buster_pt3.sh -O /debian-buster_pt3.sh
			chmod +x debian-buster_pt3.sh
fi
sleep 1
echo " "
echo "INFO ! Getting system updates."
apt-get -y update
sleep 1
apt-get -y upgrade
sleep 1
apt-get -y dist-upgrade
sleep 1
echo " "
echo "INFO ! Installing debootstrap,ftp-upload,bash,dirmngr."
apt-get install -y debootstrap ftp-upload bash dirmngr
sleep 1
echo " "
echo "INFO ! Downloading debian & selected packages."
debootstrap --keyring /etc/apt/trusted.gpg.d/debian-archive-buster-stable.gpg --force-check-gpg --variant=minbase --components=main,contrib,non-free --include=dirmngr,apt-transport-https,wget,bzip2,bash,nano,ca-certificates,software-properties-common --arch=amd64 buster /debian-buster http://deb.debian.org/debian/
echo " "
echo "INFO ! Filesystem size uncompressed."
du --human-readable --summarize debian-buster
sleep 5
echo " "
echo "INFO ! Mounting folders for root."
mount --bind /dev debian-buster/dev
mount --bind /dev/pts debian-buster/dev/pts
mount --bind /proc debian-buster/proc
mount --bind /sys debian-buster/sys
sleep 1
cp -v debian-buster_pt2.sh /debian-buster
echo " "
echo "INFO ! Changeing to new root."
sleep 1
chroot debian-buster
exit
