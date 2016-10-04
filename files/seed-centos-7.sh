#!/usr/bin/env bash

set -e
set -x

if [ -d "/etc/ansible" ]; then
    exit 42
fi

yum makecache -y

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
