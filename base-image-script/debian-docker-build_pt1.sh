#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

RELEASE=stable

echo " "
echo "INFO ! Downloading other parts of the script if needed."
if [ -e /debian-docker-build_pt2.sh ]
	then
		echo "INFO ! debian-docker-build_pt2.sh found ... will not download."
	else
		echo " "
		echo "WARNING ! debian-docker-build_pt2.sh not found ... will download new copy."
			wget --no-cache https://raw.githubusercontent.com/fithwum/base-image/refs/heads/main/build-script/debian-docker-build_pt2.sh -O /debian-docker-build_pt2.sh
			chmod +x debian-docker-build_pt2.sh
fi
if [ -e /debian-docker-build_pt3.sh ]
	then
		echo "INFO ! debian-docker-build_pt3.sh found ... will not download."
	else
		echo " "
		echo "WARNING ! debian-docker-build_pt3.sh not found ... will download new copy."
			wget --no-cache https://raw.githubusercontent.com/fithwum/base-image/refs/heads/main/build-script/debian-docker-build_pt3.sh -O /debian-docker-build_pt3.sh
			chmod +x debian-docker-build_pt3.sh
fi
sleep 1
echo " "
echo "INFO ! Getting system updates."
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
apt autoremove -y
echo " "
echo "INFO ! Installing debootstrap,ftp-upload,bash,dirmngr,curl."
sleep 1
apt-get install -y debootstrap ftp-upload bash dirmngr curl
sleep 1
echo " "
echo "INFO ! Downloading debian & selected packages."
debootstrap --force-check-gpg --variant=minbase --components=main,contrib,non-free --include=dirmngr,apt-transport-https,bash,software-properties-common,ca-certificates,wget,curl,nano,docker --arch=amd64 bookworm /debian-bookworm http://deb.debian.org/debian/
echo " "
echo "INFO ! Filesystem size uncompressed."
sleep 1
du --human-readable --summarize debian-bookworm
sleep 5
echo " "
echo "INFO ! Mounting folders for root."
mount --bind /dev debian-bookworm/dev
mount --bind /dev/pts debian-bookworm/dev/pts
mount --bind /proc debian-bookworm/proc
mount --bind /sys debian-bookworm/sys
sleep 1
cp -v debian-bookworm_pt2.sh /debian-bookworm
echo " "
echo "INFO ! Changeing to new root."
sleep 1
chroot debian-bookworm
exit
