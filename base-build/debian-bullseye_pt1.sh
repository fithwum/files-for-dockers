#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

RELEASE=stable

echo " "
echo "INFO ! Downloading other parts of the script if needed."
if [ -e /debian-bullseye_pt2.sh ]
	then
		echo "INFO ! debian-bullseye_pt2.sh found ... will not download."
	else
		echo " "
		echo "WARNING ! debian-bullseye_pt2.sh not found ... will download new copy."
			wget --no-cache https://raw.githubusercontent.com/fithwum/files-for-dockers/master/base-build/debian-bullseye_pt2.sh -O /debian-bullseye_pt2.sh
			chmod +x debian-bullseye_pt2.sh
fi
if [ -e /debian-bullseye_pt3.sh ]
	then
		echo "INFO ! debian-bullseye_pt3.sh found ... will not download."
	else
		echo " "
		echo "WARNING ! debian-bullseye_pt3.sh not found ... will download new copy."
			wget --no-cache https://raw.githubusercontent.com/fithwum/files-for-dockers/master/base-build/debian-bullseye_pt3.sh -O /debian-bullseye_pt3.sh
			chmod +x debian-bullseye_pt3.sh
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
apt autoremove -y
sleep 1
echo " "
echo "INFO ! Installing debootstrap,ftp-upload,bash,dirmngr."
apt-get install -y debootstrap ftp-upload bash dirmngr
sleep 1
echo " "
echo "INFO ! Downloading debian & selected packages."
debootstrap --keyring /etc/apt/trusted.gpg.d/debian-archive-bullseye-stable.gpg --force-check-gpg --variant=minbase --components=main,contrib,non-free --include=dirmngr,apt-transport-https,wget,bzip2,bash,nano,ca-certificates,software-properties-common --arch=amd64 bullseye /debian-bullseye http://deb.debian.org/debian/
echo " "
echo "INFO ! Filesystem size uncompressed."
du --human-readable --summarize debian-bullseye
sleep 5
echo " "
echo "INFO ! Mounting folders for root."
mount --bind /dev debian-bullseye/dev
mount --bind /dev/pts debian-bullseye/dev/pts
mount --bind /proc debian-bullseye/proc
mount --bind /sys debian-bullseye/sys
sleep 1
cp -v debian-bullseye_pt2.sh /debian-bullseye
echo " "
echo "INFO ! Changeing to new root."
sleep 1
chroot debian-bullseye
exit