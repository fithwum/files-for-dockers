#!/bin/bash
# Copyright (c) 2025 fithwum
# All rights reserved
set -e
set -o pipefail

DEBIAN_RELEASE="bookworm"
ROOTFS_DIR="debian-${DEBIAN_RELEASE}"
SCRIPTS_URL="https://raw.githubusercontent.com/fithwum/files-for-dockers/refs/heads/master/base-image-script/"
PT2_SCRIPT="debian-${DEBIAN_RELEASE}_pt2.sh"
PT3_SCRIPT="debian-${DEBIAN_RELEASE}_pt3.sh"

echo "[INFO] Preparing environment..."
apt-get update -y
apt-get upgrade -y
apt-get install -y --no-install-recommends debootstrap bash curl wget ftp-upload dirmngr

echo "[INFO] Downloading extra scripts if missing..."
for SCRIPT in $PT2_SCRIPT $PT3_SCRIPT; do
    if [ ! -f "./$SCRIPT" ]; then
        echo "[INFO] Downloading $SCRIPT..."
        wget --no-cache "$SCRIPTS_URL/$SCRIPT" -O "./$SCRIPT"
        chmod +x "./$SCRIPT"
    fi
done

echo "[INFO] Bootstrapping Debian $DEBIAN_RELEASE..."
debootstrap \
  --variant=minbase \
  --components=main,contrib,non-free \
  --include=apt,ca-certificates \
  --arch=amd64 \
  "$DEBIAN_RELEASE" "$ROOTFS_DIR" http://deb.debian.org/debian/

echo "[INFO] Mounting system directories..."
for dir in dev dev/pts proc sys; do
    mount --bind /$dir "$ROOTFS_DIR/$dir"
done

echo "[INFO] Copying pt2 script into chroot..."
cp "./$PT2_SCRIPT" "$ROOTFS_DIR/root/$PT2_SCRIPT"
chmod +x "$ROOTFS_DIR/root/$PT2_SCRIPT"

echo "[INFO] Entering chroot. Type 'exit' when done."
chroot "$ROOTFS_DIR" /root/$PT2_SCRIPT

echo "[INFO] Running pt3 for packaging and upload..."
./$PT3_SCRIPT "$ROOTFS_DIR"
