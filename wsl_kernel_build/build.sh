#!/bin/bash

RELEASE=$1
SRC_DIR=./WSL2-Linux-Kernel-${RELEASE}

cd /var/tmp

if [ ! -d "${SRC_DIR}" ]; then
  aria2c -x 10 https://github.com/microsoft/WSL2-Linux-Kernel/archive/${RELEASE}.tar.gz
  tar -xzf WSL2-Linux-Kernel-${RELEASE}.tar.gz
  cd ./WSL2-Linux-Kernel-${RELEASE}
  cp ./Microsoft/config-wsl .config
else
  cd ./WSL2-Linux-Kernel-${RELEASE}
  make -j 4
fi
exit
