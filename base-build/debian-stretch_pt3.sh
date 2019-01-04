#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

RELEASE=

echo " "
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
ftp-upload -v -h {IP}:{PORT} -u {USER} --password {PASSWORD} -d /files debian-stretch.tar
sleep 1
echo " "
echo "INFO ! Removing temp files"
rm -frv debian-stretch
exit
