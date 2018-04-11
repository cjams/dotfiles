#!/bin/bash
set -e

cd /tmp

#
# Install AUR dependencies
#
if [ ! -d ncurses5-compat-libs ];
then
    git clone https://aur.archlinux.org/ncurses5-compat-libs.git
fi

if [ ! -d libtinfo-5 ];
then
    git clone https://aur-dev.archlinux.org/libtinfo-5.git
fi

pushd ncurses5-compat-libs
makepkg -i -s --needed --noconfirm
popd

pushd libtinfo-5
makepkg -i -s --needed --noconfirm
popd

rm -rf ncurses5-compat-libs
rm -rf libtinfo-5

#
# Build cquery
#
git clone https://github.com/cquery-project/cquery.git --recursive
mkdir -p cquery-build
cd cquery-build
cmake -DCMAKE_BUILD_TYPE=Release ../cquery
make -j$(nproc)
sudo make install
