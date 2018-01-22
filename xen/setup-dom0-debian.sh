#!/bin/bash
set -e

if [ $# -ne 1 ]; then
	echo "Usage: setup-dom0-debian.sh <xen_src>"
	exit
fi

if [ $EUID -ne 0 ]; then
	echo "Please run as root"
	exit
fi

src="$1"

#
# Fetch dependencies (note that
#
echo "Fetching dependencies (NOTE: LaTex deps not being fetched)"
apt install -y build-essential apt bcc bin86 gawk bridge-utils
apt install -y iproute libcurl3 libcurl4-openssl-dev libsystemd-dev
apt install -y bzip2 kmod transfig tgif make gcc libc6-dev-i386
apt install -y libsdl-dev libjpeg62-turbo-dev iasl libbz2-dev 
apt install -y git-core uuid-dev ocaml ocaml-findlib libx11-dev 
apt install -y xz-utils libyajl-dev gettext libpixman-1-dev libaio-dev
apt install -y checkpolicy e2fslibs-dev bison flex zlib1g-dev
apt-get -y build-dep xen

cd $src
sed -i 's/PYTHON_PREFIX_DIR=/PYTHON_PREFIX_DIR=--install-layout=deb/' INSTALL
./configure --enable-systemd

make -j$(nproc) dist-xen
make -j$(nproc) dist-tools
make -j$(nproc) install-xen
make -j$(nproc) install-tools

echo "/usr/local/lib" > /etc/ld.so.conf.d/xen.conf
echo "none /proc/xen xenfs defaults,nofail 0 0" >> /etc/fstab
echo "xen-evtchn" >> /etc/modules
echo "xen-privcmd" >> /etc/modules

ldconfig
update-grub

systemctl enable xen-qemu-dom0-disk-backend.service
systemctl enable xen-init-dom0.service
systemctl enable xenconsoled.service
systemctl enable xendomains.service
systemctl enable xen-watchdog.service

reboot
