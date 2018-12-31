#!/bin
# Copyright (c) 2018 fithwum
# All rights reserved
RELEASE=
umount debian-stretch/dev/pts
umount debian-stretch/dev
umount debian-stretch/proc
umount debian-stretch/sys
sleep 2
du --human-readable --summarize debian-stretch
sleep 10
tar --verbose --create --file debian-stretch.tar --directory debian-stretch .
sleep 1
du --human-readable --summarize debian-stretch
sleep 2
tar -cvjf debian-stretch.tar.bz2 debian-stretch
sleep 1
du --human-readable --summarize debian-stretch
sleep 2
ftp-upload -v -h {IP}:{PORT} -u {USER} --password {PASSWORD} -d /files debian-stretch.tar
