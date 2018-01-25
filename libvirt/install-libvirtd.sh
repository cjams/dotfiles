#!/bin/bash

sudo pacman -S --noconfirm --needed libvirt ebtables dnsmasq qemu
sudo pacman -S --noconfirm --needed bridge-utils openbsd-netcat

# Don't do this on the open net :0
sed -i 's/#auth_unix_ro =.*/auth_unix_ro = "none"/' /etc/libvirt/libvirtd.conf
sed -i 's/#auth_unix_rw =.*/auth_unix_rw = "none"/' /etc/libvirt/libvirtd.conf
sed -i 's/#auth_tls =.*/auth_tls  = "none"/' /etc/libvirt/libvirtd.conf
sed -i 's/#auth_tcp =.*/auth_tcp  = "none"/' /etc/libvirt/libvirtd.conf
sed -i 's/#listen_tls = 0/listen_tls = 0/' /etc/libvirt/libvirtd.conf
sed -i 's/#listen_tcp = 1/listen_tcp = 1/' /etc/libvirt/libvirtd.conf
sed -i 's/LIBVIRTD_ARGS=.*/LIBVIRTD_ARGS="--listen"/' /etc/conf.d/libvirtd

# Enable ssh access via guest hostname
echo "hosts: files libvirt dns myhostname" > /etc/nsswitch.conf

echo "ALERT: You may need to reboot for libvirt to work"
systemctl start libvirtd.service
systemctl start virtlogd.service
systemctl enable libvirtd.service
