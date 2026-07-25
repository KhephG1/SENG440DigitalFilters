#!/usr/bin/bash
apt update && apt install sudo
sudo apt install git
sudo apt install build-essential
sudo apt install valgrind
sudo apt install -y clang-format #used for MISRA compliant formatting
#create a simlink so soft floating point flag can be used
sudo mkdir -p /usr/include/gnu
sudo ln -s /usr/arm-linux-gnueabi/include/gnu/stubs-soft.h /usr/include/gnu/stubs-soft.h