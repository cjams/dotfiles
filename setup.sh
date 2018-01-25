#!/bin/bash
set -e

if [[ $# -ne 1 ]]; then
    echo "Usage: setup.sh <github user name>"
    exit 1
fi

ghub_user=$1

dir="$HOME/dotfiles"

rm -rf $HOME/.config/fish
rm -rf $HOME/.gitconfig
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc

mkdir -pv $HOME/.config
mkdir -pv $HOME/aur

ln -sfv $dir/config/fish $HOME/.config/fish
ln -sfv $dir/gitconfig $HOME/.gitconfig
ln -sfv $dir/vim $HOME/.vim
ln -sfv $dir/vimrc $HOME/.vimrc

sudo pacman -Syu --noconfirm
sudo pacman -S python ctags fish git openssh vim tree --needed
sudo pacman -S asp the_silver_searcher ttf-inconsolata --needed
sudo pacman -S linux-headers libtraceevent perf x86_energy_perf_policy --needed
sudo pacman -S cpupower turbostat usbip tmon --needed

cd $HOME/aur
git clone https://aur.archlinux.org/package-query.git
git clone https://aur.archlinux.org/yaourt.git

cd $HOME/aur/package-query
makepkg -i -s --noconfirm --needed

cd $HOME/aur/yaourt
makepkg -i -s --noconfirm --needed

cd $HOME/.vim
git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
vim +PluginInstall +qall

cd $HOME/.vim/bundle/LeaderF
./install.sh

cd $HOME

if [ ! -e $HOME/.ssh/id_rsa.pub ]; then
	ssh-keygen
	git clone https://github.com/b4b4r07/ssh-keyreg.git
	./ssh-keyreg/bin/ssh-keyreg -u $ghub_user github
        rm -rf ssh-keyreg
fi

sudo cp -v $dir/linux/perf.conf /etc/sysctl.d/perf.conf
sudo sysctl -p /etc/sysctl.d/perf.conf

sudo chsh -s $(which fish) $USER
fish -c $dir/setup.fish
