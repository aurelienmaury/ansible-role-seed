#!/usr/bin/env bash

set -e
set -x

if [ -d "/etc/ansible" ]; then
    exit 42
fi

yum update -y

yum install \
  python-setuptools \
  python-devel \
  openssl-devel \
  sudo \
  libffi-devel \
  git \
  gcc \
  gcc-c++ \
  make \
  openssl-devel \
  libxml2 \
  libxml2-devel \
  libxslt \
  libxslt-devel \
  perl-devel \
  automake \
  -y

for i in 1 2 3 4 5; do easy_install pip && break || sleep 2; done

pip install -U pyopenssl ndg-httpsclient pyasn1

pip install -U pip ansible

mkdir -p /etc/ansible/
