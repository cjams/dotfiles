#!/usr/bin/bash

qemu-system-x86_64 \
    -cdrom /root/archlive/out/archlinux-2018.01.21-x86_64.iso \
    -net nic,model=virtio \
    -drive file=bfdev.img,format=raw,if=virtio \
    -enable-kvm \
    -boot order=d \
    -m 4096
