#!/bin/bash
set -e

ROOTFS_DIR="$1"
OUTPUT_TAR="$2"

echo "[INFO] Unmounting system dirs..."
sudo umount -lf "$ROOTFS_DIR/dev"
sudo umount -lf "$ROOTFS_DIR/proc"
sudo umount -lf "$ROOTFS_DIR/sys"

echo "[INFO] Cleaning up chroot script..."
sudo rm -f "$ROOTFS_DIR/alpine-base_pt2.sh"

echo "[INFO] Creating tarball: $OUTPUT_TAR"
sudo tar -czf "$OUTPUT_TAR" -C "$ROOTFS_DIR" .

echo "[INFO] Image size:"
du -sh "$OUTPUT_TAR"

# OPTIONAL FTP upload
 echo "[INFO] Uploading via FTP..."
 ftp-upload -v -h <IP> -u <USER> --password <PASS> -d /path "$OUTPUT_TAR"

echo "[INFO] Cleaning up rootfs directory..."
sudo rm -rf "$ROOTFS_DIR"

echo "[INFO] Done."
