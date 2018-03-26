#!/bin/bash

sudo ./qemu-system-x86_64 -L. -enable-kvm -cpu host --bios./OVMF.fd \
    -net none -m 1024 -smp 2 arch.qcow2 \
    -usb -serial stdio -netdev user,id=user.0 -device e1000,netdev=user.0 \
    -device usb-ehci,id=ehci -s \
    -debugcon file:debug.out -global isa-debugcon.iobase=0x402
