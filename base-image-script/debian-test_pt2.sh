#!/bin/bash
echo "[CHROOT] Configuring Debian system..."

echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/10-assume_yes

apt-get update
apt-get upgrade

apt-get install software-properties-common bash wget curl nano python3 python3-pip python3-venv locales

dpkg -l | grep python3-cryptography || echo "[OK] Not installed"

sleep 30

echo "[CHROOT] Removing unnecessary packages..."
apt-get remove --purge --allow-remove-essential pinentry-curses whiptail kmod iptables iproute2 dmidecode || true

echo "[CHROOT] Cleaning up..."
apt-get clean
apt-get install -f
find /var/lib/apt/lists/ -type f -delete

echo "[CHROOT] Done. Type 'exit' to return."
exit
