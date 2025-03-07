#!/bin/bash

set -eu

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
target_user="${1:-cs144-user}"


export DEBIAN_FRONTEND=noninteractive

apt-get update &&\
    yes | unminimize

apt-get -y install passwd sudo
which useradd

apt-get update

# Do main setup
$SCRIPT_DIR/container-setup-common $target_user

# create binary reporting version of dockerfile
(echo '#\!/bin/sh'; echo 'echo 1') > /usr/bin/cs144-docker-version && chmod ugo+rx,u+x,go-w /usr/bin/cs144-docker-version

rm -f /root/.bash_logout
