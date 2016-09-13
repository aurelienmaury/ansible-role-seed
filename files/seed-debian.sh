#!/usr/bin/env bash

set -e
set -x

if [ ! -d "/etc/ansible" ]; then
    export DEBIAN_FRONTEND=noninteractive
    apt-get update

    if [ -n "$(dpkg-query -l python-pip 2> /dev/null)" ]; then
        apt-get -o Dpkg::Options::="--force-confold" remove python-pip --purge -y
    fi

    apt-get -o Dpkg::Options::="--force-confold" upgrade -y

    apt-get update

    apt-get -o Dpkg::Options::="--force-confold" install \
        sudo                \
        aptitude            \
        git                 \
        python-apt          \
        apt-transport-https \
        python-distutils-extra \
        python-setuptools   \
        python-apt-dev      \
        python-dev          \
        libssl-dev          \
        libffi-dev          \
        build-essential     \
        libperl-dev         \
        -y

    for i in 1 2 3 4 5; do easy_install pip && break || sleep 2; done

    pip install -U pyopenssl ndg-httpsclient pyasn1

    pip install -U pip ansible

    mkdir -p /etc/ansible/
fi
