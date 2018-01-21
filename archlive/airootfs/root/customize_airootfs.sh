#!/bin/bash

set -e -u

echo KEYMAP=us > /etc/vconsole.conf
echo FONT=ter-124n >> /etc/vconsole.conf

cp -aT /etc/skel/ /root/
chmod 700 /root

useradd -G wheel -U -m dev

echo 'root ALL=(ALL) ALL' > /etc/sudoers
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
chown -c root:root /etc/sudoers
chmod -c 0440 /etc/sudoers

echo -e 'EDITOR=vim' > /etc/environment

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

systemctl enable pacman-init.service choose-mirror.service
systemctl set-default multi-user.target
