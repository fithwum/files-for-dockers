#!/bin/bash
echo "[CHROOT] Configuring Debian system..."
echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/10-assume_yes

apt-get update
apt-get upgrade

echo "[CHROOT] Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install --no-install-recommends nodejs

echo "[CHROOT] Installing Docker..."
apt-get install ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

apt-get install --no-install-recommends docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
apt-get install --no-install-recommends software-properties-common bash wget curl nano python3 python3-pip python3-venv locales

dpkg -l | grep python3-cryptography || echo "[OK] Not installed"

echo "[CHROOT] Removing unnecessary packages..."
apt-get remove --purge --allow-remove-essential pinentry-curses whiptail kmod iptables iproute2 dmidecode || true

echo "[CHROOT] Cleaning up..."
apt-get clean
apt-get install -f
find /var/lib/apt/lists/ -type f -delete

echo "[CHROOT] Done. Type 'exit' to return."
exit
