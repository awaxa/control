#!/bin/sh

dd if=/dev/zero of=/swapfile bs=1M count=4096
mkswap -f /swapfile
swapon /swapfile
