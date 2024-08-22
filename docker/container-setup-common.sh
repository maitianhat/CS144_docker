#!/bin/bash

set -eu

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
target_user="${1:-cs144-user}"

echo $target_user

# set up default locale
export LANG=en_US.UTF-8

# install GCC-related packages
apt-get -y install \
  build-essential \
  binutils-doc \
  cpp-doc \
  gcc-doc \
  g++ \
  g++-multilib \
  gdb \
  gdb-doc \
  gdbserver \
  glibc-doc \
  make \
  make-doc \
  cmake \
  cmake-doc

# install clang-related packages
apt-get -y install \
  clang \
  clang-14-doc \
  lldb \
  clang-format \
  clang-tidy

# install programs used for helper
apt-get -y install \
  sloccount \
  clangd

# install programs used for system exploration
apt-get -y install \
  strace \
  pkg-config \
  tcpdump \
  tshark

# install interactive programs (vim, man, suod, etc.)
apt-get -y install \
  git \
  git-doc \
  man \
  sudo \
  wget \
  file \
  xxd

# set up libraries
apt-get -y install \
  libreadline-dev \
  locales \
  wamerican \
  libssl-dev

# generate default locale
locale-gen en_US.UTF-8

# install programs used for networking
apt-get -y install \
  dnsutils \
  inetutils-ping \
  iproute2 \
  net-tools \
  netcat-openbsd \
  telnet \
  time \
  traceroute

# remove unneeded .deb files
rm -r /var/lib/apt/lists/*

# remove unused user
userdel -r ubuntu

# Set up the container user
if [[ $target_user == "cs144-user" ]]; then
    useradd -m -s /bin/bash $target_user
else
    # If using the host's user, don't create one--podman will do this
    # automatically. However, the default shell will be wrong, so set
    # a profile rule to update this
    chmod +x /etc/profile.d/20-fix-default-shell.sh # Copied in Podmanfile
fi

# Set up passwordless sudo for user cs144-user
echo "${target_user} ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/cs144-init
