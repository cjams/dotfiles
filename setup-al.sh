#!/bin/bash
set -e

dir="$HOME/dotfiles"

sudo amazon-linux-extras install epel -y
sudo yum install -y zsh the_silver_searcher tree util-linux-user

# Setup vimage

cp -v $dir/vimrc $HOME/.vimrc

if [ ! -d $HOME/.vim/bundle ];
then
    mkdir -p $HOME/.vim
    cd $HOME/.vim
    git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
    vim +PluginInstall +qall
fi

cd $HOME

ZSH_BASE="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

if [ ! -d $ZSH_BASE ];
    # Get oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d $ZSH_CUSTOM ];
then
    mkdir -p $ZSH_CUSTOM/{plugins,themes}

    git clone --depth=1 https://github.com/softmoth/zsh-vim-mode $ZSH_CUSTOM/plugins/zsh-vim-mode
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone --depth=1 https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
    git clone --depth=1 https://github.com/romkatv/powerlevel10k $ZSH_CUSTOM/themes/powerlevel10k

    # Link custom zsh bits
    ln -fsv $dir/oh-my-zsh/custom/alias.zsh $ZSH_CUSTOM/alias.zsh
    ln -fsv $dir/oh-my-zsh/custom/bindkey.zsh $ZSH_CUSTOM/bindkey.zsh
fi
