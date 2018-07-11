#!/bin/bash

sudo ln -sf /usr/bin/python2 /usr/bin/python
sudo pacman -S iasl python2-yaml ovmf --needed --no-confirm
./configure --disable-rombios --disable-docs
sudo make install -j$(nproc)

if [ ! -d /boot/efi/EFI/xen ];
then
    mkdir /boot/efi/EFI/xen
fi

sudo systemctl enable xenstored
sudo systemctl enable xenconsoled
sudo systemctl enable xendomains
sudo systemctl enable xen-init-dom0

sudo cp xen/xen.efi /boot/efi/EFI/xen/
echo "Please cp vmlinuz-linux's, initramfs, and xen.cfg to /boot/efi/EFI/xen"
