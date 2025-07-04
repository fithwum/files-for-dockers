#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

echo "[CHROOT] Updating apt and setting locale..."
apt-get update
apt-get install -y locales
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
export LANG=en_US.UTF-8

echo "[CHROOT] Installing python3-cryptography safely..."
apt-get install -y python3-cryptography

echo "[CHROOT] Configuring Debian system..."

echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/10-assume_yes

apt-get update
apt-get upgrade

echo "[CHROOT] Removing unnecessary packages..."
apt-get remove --purge --allow-remove-essential pinentry-curses whiptail kmod iptables iproute2 dmidecode || true

echo "[CHROOT] Cleaning up..."
dpkg --configure -a
apt-get install -f
apt-get clean
rm -rf /var/lib/apt/lists/*

echo "[CHROOT] Done. Type 'exit' to return."
exit
