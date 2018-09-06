#!/bin/bash

sudo ln -sf /usr/bin/python2 /usr/bin/python
sudo pacman -S yajl bin86 iasl python2-yaml --needed --noconfirm
./configure --disable-rombios --disable-docs --disable-stubdom --disable-seabios --prefix=/usr
make -j$(nproc)

if [ ! -d /boot/efi/EFI/xen ];
then
    mkdir /boot/efi/EFI/xen
fi

sudo systemctl enable xenstored
sudo systemctl enable xenconsoled
sudo systemctl enable xendomains
sudo systemctl enable xen-init-dom0

sudo cp xen/xen.efi /boot/efi/EFI/xen/
sudo chown -R dev:users .
echo "Please cp vmlinuz-linux's, initramfs, and xen.cfg to /boot/efi/EFI/xen"
