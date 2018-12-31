#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved
# Setup the target partition for install
mkfs.ext4 -L Debian /dev/sda1
mkdir /mnt/deboot
mount -t ext4 /dev/sda1 /mnt/deboot
# Installing the base system with network access
debootstrap --include linux-image-amd64,grub-pc,locales --arch amd64 unstable /mnt/deboot http://ftp.us.debian.org/debian
# Preparing the chroot environment
cp /etc/mtab /mnt/deboot/etc/mtab
mount -o bind /dev /mnt/deboot/dev
mount -o bind /proc /mnt/deboot/proc
mount -o bind /sys /mnt/deboot/sys
# Continuing the installation within chroot
chroot /mnt/deboot /bin/bash
grub-install /dev/sda
update-grub
blkid /dev/sda1
UUID=79168060-9d9c-4cf6-8ee9-bb846aee589b / ext4 defaults,errors=remount-ro 0 1
echo "debian" > /etc/hostname
dpkg-reconfigure locales
passwd
adduser user
# Setting up the network (eth0)
dhclient -v eth0
# Finishing the install
apt-get clean
update-initramfs -u -k all
exit