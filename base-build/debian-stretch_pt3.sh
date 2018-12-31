#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

umount debian-stretch/dev/pts
umount debian-stretch/dev
umount debian-stretch/proc
umount debian-stretch/sys
sleep 2
du --human-readable --summarize debian-stretch
sleep 2
tar --verbose --create --file debian-stretch.tar --directory debian-stretch .
sleep 2
sudo tar -cvjf debian-stretch.tar.bz2 debian-stretch
sleep 2
ftp-upload -v -h 192.168.1.92:8001 -u {} --password {} -d /files debian-stretch.tar
