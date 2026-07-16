#!/usr/bin/bash
apt update && apt install sudo
sudo apt install build-essential
sudo apt install valgrind
sudo apt install -y clang-format #used for MISRA compliant formatting
