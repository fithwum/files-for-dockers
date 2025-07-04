#!/bin/bash
# Copyright (c) 2025 fithwum
# All rights reserved
echo "[CHROOT] Inside Alpine rootfs"

echo "[CHROOT] Updating system..."
apk update
apk upgrade

echo "[CHROOT] Optional cleanup of packages"
# apk del some-unneeded-package

echo "[CHROOT] Cleaning apk cache..."
rm -rf /var/cache/apk/*

echo "[CHROOT] Done. Type 'exit' to return to host script."
exit
