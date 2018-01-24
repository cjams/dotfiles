cd /home/cjd
ls
rm -rf .oh-my-zsh/
top
sudo pacman -S htop
htop
chsh -s /usr/bin/fish cjd
reboot
cat < /dev/pts/0
cat < /dev/pts/0
clear
exit
chsh -s /bin/bash cjd
pacman -Ql fish
man pacman
ls
reboot
killall fish
man fish
ls
cd .config/
ls
ls
cd /home/cjd
ls
cd .config/fish
ls
rm config.fish 
vim conf.d/omf.fish 
clear
ls
exit
killall fish
vim /home/cjd/.config/fish/conf.d/omf.fish 
ls
clear
ls
pwd
cd /home/cjd/
ls
clear
ls
cd .config/
cd fish/
ls
ls -al
chmod u+x config.fish
ls -al
reboot
chmod 666 manjaro-deepin-17.0.6-stable-x86_64.iso 
ls -al
usermod -G kvm -a cjd
exit
dd if=downloads/manjaro-deepin-17.0.6-stable-x86_64.iso of=/dev/sda bs=8M && sync
systemctl enable libvirtd
systemctl start libvirtd
cat < /dev/pts/0
exit
clear
echo 1 >/sys/kernel/debug/tracing/events/kvm/enable
cat /sys/kernel/debug/tracing/trace_pipe 
ls
exit
exit
exit
tail -f dbg.log 
clear
mount | grep debug
exit
ping archlinux.rg
ping archlinux.org
clear
cd /home/cjd
ls
git clone git@github.com:torvalds/linux.git
git clone https://github.com/torvalds/linux.git
man git clone
git clone --shallow 1 https://github.com/torvalds.git
git clone --depth 1 https://github.com/torvalds.git
git clone --depth 1 https://github.com/torvalds/linux.git
cd linux/
ls
exit
cd /home/cjd/linux/
ls
vim .config 
setfont ter-128n
setfont ter-124n
make localmodconfig
make kvmconfig
make xenconfig
make nconfig
make nconfig
make -j4
sudo make modules_install
cp arch/x86_64/boot/bzImage /boot/vmlinuz-linux-415
cd /boot
ls
rm vmlinuz-linux-415 
cd /home
lsblk
lsblk -f
mount /dev/nvme0n1p1 /boot
cd /boot
ls
cd ..
umount /boot
mount /dev/nvme0n1p2 /boot
cd /boot
ls
rm vmlinuz-linux 
cp /home/cjd/linux/arch/x86_64/boot/bzImage vmlinuz-linux
cd /home/cjd/linux/
sudo make modules_install -j3
cd /boot
ls
mkinitpcio -p linux
mkinitcpio -p linux
cd /home/cjd/linux/
make menuconfig
make -j4
sudo make modules_install
cp arch/x86_64/boot/bzImage /boot/vmlinuz-linux
cd /boot
mkinitcpio -p linux
sync
exit
cd /boot
ls
grub-mkconfig -o /boot/grub/grug.cfg
exit
lsblk
mount /dev/nvme0n1p2 /boot
cd /boot
ls
cd efi
ls
cd ..
ls
sync
cd /
umount /boot
mount /dev/nvme0n1p1 /boot
reboot
exit
sudo pacman -Sy
pacman -S plymouth
mount /dev/nvme0n1p2 /boot
pacman -S plymouth
plymouth
man plymouth
clear
sync
vim /etc/pacman.conf 
exit
journalctl -xb
ls
cd /home/cjd
ls
cd linux/
ls
lsblk
make nconfig
make -j5
lsblk
make modules_install
setfont ter-124n
clear
ls
cd /boot
ls
vim /etc/mkinitcpio.conf 
ls
cp /home/cjd/linux/arch/x86_64/boot/bzImage vmlinuz-linux 
mkinitcpio -p linux
vim /etc/default/grub 
grub-mkconfig -o /boot/grub/grub/cfg
grub-mkconfig -o /boot/grub/grub.cfg
exit
cd /home/cjd/linux/
make nconfig
make -j4
make nconfig
make modules_install
cp arch/x86_64/boot/bzImage /boot/vmlinuz-linux 
mkinitcpio -o linux
mkinitcpio -p linux
clear
grub-mkconfig -o /boot/grub/grub.cfg
sync
poweroff
auvirt --vm cbg
auvirt --vm dbg
ip a
systemctl restart libvirtd
systemctl enable libvirtd
ip a
poweroff
systemctl start libvirtd
systemctl start virtlogd
ip a
virt-manager 
pmi bridge-utils
exit
cd
ls
git clone https://github.com/connojd/dotfiles.git
./dotfiles/setup.sh 
exit
exit
echo $SHELL
chsh -s /usr/bin/fish
exit
