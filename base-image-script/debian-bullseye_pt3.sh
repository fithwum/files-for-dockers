#!/bin/bash
# Copyright (c) 2025 fithwum
# All rights reserved
set -e

ROOTFS_DIR="${1:-debian-bullseye}"
TARBALL="${ROOTFS_DIR}.tar.bz2"

echo "[INFO] Attempting to unmount system directories (ignore errors)..."
for dir in sys proc dev/pts dev; do
    umount -lf "$ROOTFS_DIR/$dir" 2>/dev/null || true
done

echo "[INFO] Removing chroot script..."
rm -f "$ROOTFS_DIR/root/"debian-*_pt2.sh 2>/dev/null || true

echo "[INFO] Rootfs size:"
du -sh "$ROOTFS_DIR"

echo "[INFO] Creating compressed base image..."
tar -cjf "$TARBALL" -C "$ROOTFS_DIR" .

echo "[INFO] Image archive size:"
du -sh "$TARBALL"

# DO NOT DELETE TARBALL — needed by Gitea Action
# DO NOT UPLOAD HERE — handled by workflow
echo "[INFO] Leaving tarball for CI to upload: $TARBALL"