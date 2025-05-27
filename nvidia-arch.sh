#!/bin/bash

# Exit on error
set -e

echo "🔍 Detecting NVIDIA GPU..."
if ! lspci | grep -E "VGA|3D" | grep -qi nvidia; then
    echo "❌ No NVIDIA GPU detected. Exiting."
    exit 1
fi

echo "📦 Updating system..."
sudo pacman -Syu --noconfirm

echo "📥 Installing NVIDIA driver..."
sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

echo "🧹 Cleaning up old config (if any)..."
sudo rm -f /etc/X11/xorg.conf.d/20-nvidia.conf

echo "📝 Creating NVIDIA X config..."
sudo mkdir -p /etc/X11/xorg.conf.d
echo '
Section "Device"
    Identifier "Nvidia Card"
    Driver "nvidia"
EndSection
' | sudo tee /etc/X11/xorg.conf.d/20-nvidia.conf > /dev/null

echo "🧠 Regenerating initramfs..."
sudo mkinitcpio -P

echo "🔁 Enabling DRM kernel mode setting..."
if ! grep -q "nvidia_drm.modeset=1" /etc/default/grub; then
    sudo sed -i 's/GRUB_CMDLINE_LINUX="/GRUB_CMDLINE_LINUX="nvidia_drm.modeset=1 /' /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

echo "✅ NVIDIA driver installed. Please reboot your system."

