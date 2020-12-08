# IMAGE=$(sudo docker build ./ --build-arg RELEASE="$(uname -r)" | tail -n 1 | cut -d' ' -f3)
# sudo docker run -v /tmp/docker:/var/tmp --name build_kernel ${IMAGE}
# (cd /tmp/docker/kernel && sudo make modules_install)
# sudo docker run --rm -v /tmp/docker:/var/tmp --name build_kernel
# cd /tmp/docker/kernel && sudo make modules_install
# cp arch/x86/boot/bzImage /mnt/c/Users/#username$

FROM ubuntu:focal-20200423

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install \
      apt-utils \
      build-essential \
      libncurses-dev \
      bison flex \
      libssl-dev \
      libelf-dev \
      cpu-checker \
      qemu-kvm \
      bc \
      aria2

ARG RELEASE
ENV RELEASE=${RELEASE}

VOLUME /var/tmp
WORKDIR /var/tmp

RUN echo '#!/bin/bash\n\
\n\
RELEASE=$1\n\
SRC_DIR=./WSL2-Linux-Kernel-${RELEASE}\n\
\n\
cd /var/tmp\n\
\n\
if [ ! -d "${SRC_DIR}" ]; then\n\
  aria2c -x 10 https://github.com/microsoft/WSL2-Linux-Kernel/archive/${RELEASE}.tar.gz\n\
  tar -xzf WSL2-Linux-Kernel-${RELEASE}.tar.gz\n\
  ln -s ./WSL2-Linux-Kernel-${RELEASE} ./kernel\n\
  cd ./WSL2-Linux-Kernel-${RELEASE}\n\
  cp ./Microsoft/config-wsl .config\n\
else\n\
  cd ./WSL2-Linux-Kernel-${RELEASE}\n\
  make -j $(egrep -c '^processor[[:blank:]]*' /proc/cpuinfo)\n\
fi\n\
exit' >/usr/local/src/build.sh

CMD bash /usr/local/src/build.sh ${RELEASE}
