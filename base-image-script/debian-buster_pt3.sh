#!/bin/bash
# Copyright (c) 2025 fithwum
# All rights reserved
set -e

ROOTFS_DIR="${1:-debian-buster}"
TARBALL="${ROOTFS_DIR}.tar.bz2"

for dir in sys proc dev/pts dev; do
    umount -lf "$ROOTFS_DIR/$dir" 2>/dev/null || true
done

rm -f "$ROOTFS_DIR/root/debian-buster_pt2.sh" 2>/dev/null || true

du -sh "$ROOTFS_DIR"

tar -cjf "$TARBALL" -C "$ROOTFS_DIR" .

du -sh "$TARBALL"

echo "[INFO] Tarball ready for upload: $TARBALL"