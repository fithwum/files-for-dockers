#!/bin/bash
# Copyright (c) 2025 fithwum
# All rights reserved
set -e

# Alpine version
ALPINE_VERSION="v3.20"
ROOTFS_DIR="alpine-rootfs"
OUTPUT_TAR="alpine-base.tar.gz"
PACKAGES="bash curl ca-certificates nano"

echo "[INFO] Downloading alpine-make-rootfs if needed..."
if [ ! -f ./alpine-make-rootfs ]; then
    wget https://raw.githubusercontent.com/alpinelinux/alpine-make-rootfs/master/alpine-make-rootfs
    chmod +x alpine-make-rootfs
fi

echo "[INFO] Creating Alpine rootfs with selected packages..."
sudo ./alpine-make-rootfs \
    --branch "$ALPINE_VERSION" \
    --mirror http://dl-cdn.alpinelinux.org/alpine \
    --packages "$PACKAGES" \
    "$ROOTFS_DIR"

echo "[INFO] Binding system directories for chroot..."
sudo mount --bind /dev "$ROOTFS_DIR/dev"
sudo mount --bind /proc "$ROOTFS_DIR/proc"
sudo mount --bind /sys "$ROOTFS_DIR/sys"

echo "[INFO] Copying part 2 script into chroot..."
sudo cp alpine-base_pt2.sh "$ROOTFS_DIR/alpine-base_pt2.sh"
sudo chmod +x "$ROOTFS_DIR/alpine-base_pt2.sh"

echo "[INFO] Entering chroot. Run 'exit' when done."
sudo chroot "$ROOTFS_DIR" /alpine-base_pt2.sh

echo "[INFO] Continuing with packaging after chroot..."
bash alpine-base_pt3.sh "$ROOTFS_DIR" "$OUTPUT_TAR"
