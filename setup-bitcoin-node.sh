#!/bin/bash
set -e

if [ "$#" -ne 6 ]; then
    echo "Usage: setup-pi.sh -p <rpc_pass> -a <mullvad_account_id> -l <mullvad_vpn_location>"
    echo "Example: setup-pi.sh -p 'fo0bA&' -a 123459038395 -l us-den-wg-002"
    exit 22
fi

# Initialize variables for storing option values
while getopts ":p:a:l:" opt; do
  case $opt in
    p)
      rpc_pass="$OPTARG"
      ;;
    a)
      mullvad_account_id="$OPTARG"
      ;;
    l)
      mullvad_location="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Parse long-form options using case statement
for arg in "$@"; do
  if [[ $arg == --* ]]; then
    key=$(echo $arg | cut -d= -f1 | tr -d --)
    value=$(echo $arg | cut -d= -f2-)

    case $key in
      rpc-pass)
        rpc_pass=$value
        ;;
      mullvad-account-id)
        mullvad_account_id=$value
        ;;
      mullvad-location)
        mullvad_location=$value
        ;;
      *)
        echo "Invalid long-form option: $key" >&2
        exit 1
        ;;
    esac
  fi
done

dir="$HOME/dotfiles"

sudo apt update
sudo apt install -y zsh vim silversearcher-ag

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

if [ ! -d "$ZSH_BASE" ];
then
    # Get oh-my-zsh
    wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    sh install.sh --unattended

    git clone --depth=1 https://github.com/softmoth/zsh-vim-mode $ZSH_CUSTOM/plugins/zsh-vim-mode
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone --depth=1 https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
    git clone --depth=1 https://github.com/romkatv/powerlevel10k $ZSH_CUSTOM/themes/powerlevel10k

    # Link custom zsh bits
    ln -fsv $dir/oh-my-zsh/custom/alias.zsh $ZSH_CUSTOM/alias.zsh
    ln -fsv $dir/oh-my-zsh/custom/bindkey.zsh $ZSH_CUSTOM/bindkey.zsh

    cp -v $dir/zshrc $HOME/.zshrc
    cp -v $dir/p10k.zsh $HOME/.p10k.zsh

    sudo chsh -s /bin/zsh $USER
fi

# Setup mullvad VPN tunnel
sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/mullvad.list
sudo apt update
sudo apt install mullvad-vpn
mullvad account login $mullvad_account_id
mullvad lan set allow
mullvad relay set tunnel-protocol wireguard
mullvad relay set location $mullvad_location
mullvad connect

# Install bitcoin build dependencies
sudo apt install build-essential cmake pkg-config python3 libevent-dev libboost-dev libsqlite3-dev

# Build
if [ ! -d $HOME/bitcoin ]; then
    git clone https://github.com/bitcoin/bitcoin
fi
cd bitcoin

# The systemd service expects bitcoind to live under /usr/bin,
# hence we specify -DCMAKE_INSTALL_PREFIX=/usr
cmake -B build -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_TESTS=OFF -DBUILD_TESTING=OFF
cmake --build build -j$(nproc)
sudo cmake --install build

# Create bitcoin user:group
#sudo adduser --gecos "" --disabled-password bitcoin
#sudo usermod -aG bitcoin $USER

# Generate configuration
sudo mkdir -p /etc/bitcoin
sudo chown bitcoin:bitcoin /etc/bitcoin
sudo chmod 770 /etc/bitcoin
BUILDDIR=build contrib/devtools/gen-bitcoin-conf.sh

rpcauth=$(python3 share/rpcauth/rpcauth.py $USER $rpc_pass | grep 'rpcauth=' | cut -d '=' -f 2)

sed -i 's|#txindex=1|txindex=1|' share/examples/bitcoin.conf
sed -i 's|#listen=1|listen=1|' share/examples/bitcoin.conf
sed -i 's|#listenonion=1|listenonion=1|' share/examples/bitcoin.conf
sed -i 's|#server=1|server=1|' share/examples/bitcoin.conf
sed -i 's|#v2transport=1|v2transport=1|' share/examples/bitcoin.conf
sed -i 's|#dbcache=<n>|dbcache=1024|' share/examples/bitcoin.conf
sed -i 's|#rpccookieperms=<readable-by>|rpccookieperms=group|' share/examples/bitcoin.conf
sed -i 's|#datadir=<dir>|datadir=/var/lib/bitcoind|' share/examples/bitcoin.conf
sed -i "s|#rpcauth=<userpw>|rpcauth=$rpcauth|" share/examples/bitcoin.conf

sudo cp -v share/examples/bitcoin.conf /etc/bitcoin/
sudo chown bitcoin:bitcoin /etc/bitcoin/bitcoin.conf

# Generate datadir
sudo mkdir -p /var/lib/bitcoind
sudo chown bitcoin:bitcoin /var/lib/bitcoind
sudo chmod 755 /var/lib/bitcoind

# Let's get it on
sudo cp -v contrib/init/bitcoind.service /usr/lib/systemd/system/
sudo systemctl enable bitcoind.service
sudo systemctl start bitcoind.service
