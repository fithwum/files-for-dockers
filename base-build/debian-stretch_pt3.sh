#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

RELEASE=

echo "INFO ! Cleaning up pt2 of script from base image script"
rm -frv /debian-stretch/debian-stretch_pt2.sh
sleep 1
echo " "
echo "INFO ! Filesystem size after."
du --human-readable --summarize debian-stretch
sleep 10
tar -cvjf debian-stretch.tar.bz2 --directory debian-stretch .
sleep 1
echo " "
echo "INFO ! Filesystem archive."
du --human-readable --summarize debian-stretch.tar.bz2
sleep 10
echo " "
echo "INFO ! Upload image to ftp."
sleep 1
ftp-upload -v -h {IP}:{PORT} -u {USER} --password {PASSWORD} -d /files debian-stretch.tar
sleep 1
rm -frv debian-stretch
rm -frv debian-stretch_pt2.sh
rm -frv debian-stretch_pt3.sh
exit
