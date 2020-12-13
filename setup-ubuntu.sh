#!/bin/bash
set -e

pkgs="tree vim zsh silversearcher-ag curl deepin-terminal"
sudo apt install -y $pkgs

rm -rf $HOME/.gitconfig
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
rm -rf $HOME/.bashrc
rm -rf $HOME/.inputrc

dir="$HOME/dotfiles"

ln -fsv $dir/gitconfig $HOME/.gitconfig
ln -fsv $dir/vim $HOME/.vim
ln -fsv $dir/vimrc $HOME/.vimrc
ln -fsv $dir/bashrc $HOME/.bashrc
ln -fsv $dir/inputrc $HOME/.inputrc
ln -fsv $dir/zshrc $HOME/.zshrc

sed -i "s|/home/connojd|/home/$USER|" $HOME/.zshrc

cd $HOME/.vim
if [ ! -d bundle ];
then
    git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
fi

vim +PluginInstall +qall

# Get patched powerline fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

sudo mkdir -p /usr/share/fonts/truetype

sudo mv 'MesloLGS NF Regular.ttf' /usr/share/fonts/truetype/
sudo mv 'MesloLGS NF Bold.ttf' /usr/share/fonts/truetype/
sudo mv 'MesloLGS NF Italic.ttf' /usr/share/fonts/truetype/
sudo mv 'MesloLGS NF Bold Italic.ttf' /usr/share/fonts/truetype/

fc-cache -f
sed -i 's|font=\(.*\)|font=MesloLGS NF|' ~/.config/deepin/deepin-terminal/config.conf

# Get oh-my-zsh, plugins, and themes
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

git clone --depth=1 https://github.com/softmoth/zsh-vim-mode $ZSH_CUSTOM/plugins/zsh-vim-mode
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
git clone --depth=1 https://github.com/romkatv/powerlevel10k $ZSH_CUSTOM/themes/powerlevel10k

# Link custom zsh bits
ln -fsv $dir/oh-my-zsh/custom/alias.zsh $ZSH_CUSTOM/alias.zsh
ln -fsv $dir/oh-my-zsh/custom/bindkey.zsh $ZSH_CUSTOM/bindkey.zsh
