#!/bin/bash
# Copyright (c) 2025 fithwum
# All rights reserved
set -e

# Auto-detect a single debian-* directory if not passed
if [ -n "$1" ]; then
    ROOTFS_DIR="$1"
else
    ROOTFS_DIR=$(find . -maxdepth 1 -type d -name "debian-*" | sed 's|^\./||' | head -n 1)
    if [ -z "$ROOTFS_DIR" ]; then
        echo "[ERROR] No debian-* rootfs directory found!"
        exit 1
    fi
fi

TARBALL="/output/${ROOTFS_DIR}.tar.bz2"

echo "[INFO] Unmounting system directories (ignore errors)..."
for dir in sys proc dev/pts dev; do
    umount -lf "$ROOTFS_DIR/$dir" 2>/dev/null || true
done

echo "[INFO] Removing chroot script..."
rm -f "$ROOTFS_DIR/root/${ROOTFS_DIR}_pt2.sh" 2>/dev/null || true

echo "[INFO] Rootfs size:"
du -sh "$ROOTFS_DIR"

echo "[INFO] Creating compressed base image..."
tar -cjf "$TARBALL" -C "$ROOTFS_DIR" .

echo "[INFO] Image archive size:"
du -sh "$TARBALL"

echo "[INFO] Tarball ready for CI to upload: $TARBALL"
