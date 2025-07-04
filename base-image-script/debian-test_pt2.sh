#!/bin/bash
echo "[CHROOT] Configuring Debian system..."

echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/10-assume_yes

apt-get update
apt-get upgrade

echo "[CHROOT] Removing unnecessary packages..."
apt-get remove --purge --allow-remove-essential pinentry-curses whiptail kmod iptables iproute2 dmidecode || true

echo "[CHROOT] Cleaning up..."
apt-get clean
apt-get install -f
find /var/lib/apt/lists/ -type f -delete

echo "[CHROOT] Done. Type 'exit' to return."
exit
