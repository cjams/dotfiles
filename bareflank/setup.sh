#!/bin/bash

sudo pacman -Syu
sudo pacman -S clang cmake linux-headers nasm ninja

mkdir -p $HOME/bareflank/build
pushd $HOME/bareflank

git clone -b dev https://github.com/connojd/hypervisor.git
pushd hypervisor

git remote add upstream https://github.com/Bareflank/hypervisor.git
