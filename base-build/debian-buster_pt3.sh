#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

echo " "
echo "INFO ! Cleaning up pt2 of script from base image."
rm -frv /debian-buster/debian-buster_pt2.sh
sleep 1
echo " "
echo "INFO ! Base image size after cleanup."
du --human-readable --summarize debian-buster
sleep 10
echo " "
echo "INFO ! Creating base image archive."
echo "INFO ! This may take some time."
tar -cjf debian-buster.tar.bz2 --directory debian-buster .
sleep 1
echo " "
echo "INFO ! Base image archive."
du --human-readable --summarize debian-buster.tar.bz2
sleep 10
echo " "
echo "INFO ! Uploading image to ftp server."
ftp-upload -v -h {IP}:{PORT} -u {USER} --password {PASSWORD} -d /mnt/user/FTP debian-buster.tar.bz2
sleep 1
echo " "
echo "INFO ! Removing temp files."
rm -fr debian-buster
rm -frv debian-buster.tar.bz2
echo " "
echo "INFO ! Done."
echo " "
exit
