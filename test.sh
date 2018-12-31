#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved


mkfs.ext4 -L Debian /dev/sda1
host# mkdir /mnt/deboot
mount -t ext4 /dev/sda1 /mnt/deboot