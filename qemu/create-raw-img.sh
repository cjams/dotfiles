#!/usr/bin/bash

if [ $# -lt 2 ];
then
    echo "usage: ./create-raw-img.sh <name> <size-in-GB>"
    exit
fi

# create a raw qemu image
qemu-img create -f raw $1.img $2G
