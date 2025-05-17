#!/bin/bash

# This script installs the NVIDIA proprietary driver on Debian systems.

# Root check
if [[ $EUID -ne 0 ]]; then
  echo "❌ Please run this script as root (e.g., with sudo)."
  exit 1
fi

# Enable non-free and contrib if not already enabled
echo "📦 Ensuring 'contrib', 'non-free', and 'non-free-firmware' components are enabled..."
sed -i '/^deb / s/main/main contrib non-free non-free-firmware/' /etc/apt/sources.list

# Update package index
echo "🔄 Updating package lists..."
apt update

# Check for NVIDIA GPU
echo "🔍 Checking for NVIDIA GPU..."
if lspci | grep -i nvidia >/dev/null; then
  echo "✅ NVIDIA GPU found."
else
  echo "❌ No NVIDIA GPU detected."
  exit 1
fi

# Install kernel headers
echo "📥 Installing kernel headers..."
apt install -y linux-headers-$(uname -r)

# Install NVIDIA driver
echo "📥 Installing 'nvidia-driver' package (recommended for RTX 3060)..."
apt install -y nvidia-driver

echo "✅ NVIDIA driver installation complete."
echo "🔁 Reboot your system to apply changes."

sleep 2

sudo reboot
