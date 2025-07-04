#!/bin/bash
set -e

ROOTFS_DIR="${1:-debian-bookworm}"
TARBALL="${ROOTFS_DIR}.tar.bz2"

echo "[INFO] Unmounting system directories..."
for dir in sys proc dev/pts dev; do
    umount -lf "$ROOTFS_DIR/$dir"
done

echo "[INFO] Removing chroot script..."
rm -f "$ROOTFS_DIR/root/debian-base_pt2.sh"

echo "[INFO] Showing rootfs size..."
du -sh "$ROOTFS_DIR"

echo "[INFO] Creating compressed base image..."
tar -cjf "$TARBALL" -C "$ROOTFS_DIR" .

echo "[INFO] Image archive size:"
du -sh "$TARBALL"

# Optional: Upload via FTP
# ftp-upload -v -h "$HOST" -u "$USER" --password "$PASS" -d /target/dir "$TARBALL"

echo "[INFO] Cleaning up..."
rm -rf "$ROOTFS_DIR"
rm -f "$TARBALL"

echo "[INFO] Done."
