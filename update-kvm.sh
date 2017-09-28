#!/bin/bash

sudo modprobe -r kvm_intel
sudo modprobe -r kvm

KVMSRC=arch/x86/kvm
make M=$KVMSRC

gzip $KVMSRC/kvm.ko
gzip $KVMSRC/kvm-intel.ko

sudo cp -f $KVMSRC/kvm.ko.gz /usr/lib/modules/`uname -r`/kernel/$KVMSRC/
sudo cp -f $KVMSRC/kvm-intel.ko.gz /usr/lib/modules/`uname -r`/kernel/$KVMSRC/

sudo modprobe kvm
sudo modprobe kvm_intel
