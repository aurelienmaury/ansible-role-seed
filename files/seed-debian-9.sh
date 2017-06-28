#!/usr/bin/env bash

set -e
set -x

if [ -d "/etc/ansible" ]; then
    exit 42
fi

export DEBIAN_FRONTEND=noninteractive


if [ -n "$(dpkg -l | grep exim)" ]; then
    apt-get -o Dpkg::Options::="--force-confold" install postfix -y
    apt-get -o Dpkg::Options::="--force-confold" remove exim4 exim4-base exim4-config exim4-daemon-light --purge -y
fi

if [ -n "$(dpkg -l | grep python-pip)" ]; then
    apt-get -o Dpkg::Options::="--force-confold" remove python-pip --purge -y
fi

apt-get update
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

cat << EOT > /etc/pip.constraints
pycparser == 2.13
EOT

cat << EOF > /etc/pip.conf
[install]
constraint = /etc/pip.constraints
EOF

pip install -U pyopenssl ndg-httpsclient pyasn1

pip install -U pip ansible

mkdir -p /etc/ansible/
