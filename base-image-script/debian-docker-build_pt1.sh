#!/bin/bash
# Copyright (c) 2025 fithwum
# All rights reserved
set -e
set -o pipefail

DEBIAN_RELEASE="docker-build"
ROOTFS_DIR="debian-${DEBIAN_RELEASE}"
SCRIPTS_DIR="base-image-script"
PT2_SCRIPT="debian-${DEBIAN_RELEASE}_pt2.sh"
PT3_SCRIPT="debian-${DEBIAN_RELEASE}_pt3.sh"

echo "[INFO] Preparing environment..."
apt-get update -y
apt-get upgrade -y
apt-get install -y --no-install-recommends debootstrap bash curl wget dirmngr bzip2

for SCRIPT in $PT2_SCRIPT $PT3_SCRIPT; do
    if [ ! -f "./${SCRIPTS_DIR}/$SCRIPT" ]; then
        echo "[ERROR] Missing script: ${SCRIPTS_DIR}/$SCRIPT"
        exit 1
    fi
done

echo "[INFO] Bootstrapping Debian $DEBIAN_RELEASE rootfs..."
debootstrap --variant=minbase --components=main,contrib,non-free --include=apt,ca-certificates --arch=amd64 bookworm "$ROOTFS_DIR" http://deb.debian.org/debian/

for dir in dev dev/pts proc sys; do
    mount --bind "/$dir" "$ROOTFS_DIR/$dir"
done

cp "./${SCRIPTS_DIR}/$PT2_SCRIPT" "$ROOTFS_DIR/root/$PT2_SCRIPT"
chmod +x "$ROOTFS_DIR/root/$PT2_SCRIPT"

chroot "$ROOTFS_DIR" /root/$PT2_SCRIPT

bash "./${SCRIPTS_DIR}/$PT3_SCRIPT" "$ROOTFS_DIR"