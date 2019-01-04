#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

RELEASE=

echo "Unmounting folders for root"
sleep 1
umount debian-stretch/dev/pts
sleep 1
umount debian-stretch/dev
sleep 1
umount debian-stretch/proc
sleep 1
umount debian-stretch/sys
echo "cleaning up unneeded script"
rm -frv /debian-stretch/debian-stretch_pt2.sh
sleep 1
echo "Filesystem size after."
sleep 1
du --human-readable --summarize debian-stretch
sleep 10
tar -cvjf debian-stretch.tar.bz2 --directory debian-stretch .
sleep 1
echo "Filesystem archive."
sleep 1
du --human-readable --summarize debian-stretch.tar.bz2
sleep 10
echo "upload to ftp."
sleep 1
ftp-upload -v -h {IP}:{PORT} -u {USER} --password {PASSWORD} -d /files debian-stretch.tar
sleep 1
rm -frv debian-stretch
rm -frv debian-stretch_pt2.sh
rm -frv debian-stretch_pt3.sh
rm -frv debian-stretch.tar.bz2
exit
