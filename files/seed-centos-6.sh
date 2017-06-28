#!/usr/bin/env bash

set -e
set -x

if [ -h "/usr/bin/ansible" ]; then
    exit 42
fi

yum makecache -y

yum update -y

yum install \
  openssl-devel \
  sudo \
  readline-devel \
  sqlite-devel \
  libffi-devel \
  libselinux-python \
  python-setuptools \
  python-devel \
  patch \
  git \
  gcc \
  gcc-c++ \
  make \
  libxml2 \
  libxml2-devel \
  libxslt \
  libxslt-devel \
  perl-devel \
  automake \
  -y

easy_install \
    virtualenv \
    urllib3 \
    pyopenssl \
    ndg-httpsclient \
    pyasn1

[ -d "/root/.ssh" ] || mkdir /root/.ssh

ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts

cd /usr/local/lib

[ -d "/usr/local/lib/pyenv" ] || git clone git://github.com/yyuu/pyenv.git

cat > /etc/profile.d/pyenv.sh << EOF
export PYENV_ROOT="/usr/local/lib/pyenv"
export PATH="\$PYENV_ROOT/bin:\$PATH"
EOF

. /etc/profile.d/pyenv.sh

eval "$(pyenv init -)"

pyenv install 2.7.12 --skip-existing

pyenv global 2.7.12

eval "$(pyenv init -)"

pip install -U virtualenv pyopenssl ndg-httpsclient pyasn1

pip install -U pip ansible

mkdir -p /etc/ansible/facts.d

cat << EOF > /etc/ansible/facts.d/ansible_python_interpreter.fact
"/usr/local/lib/pyenv/shims/python2.7"
EOF

cat << EOF > /etc/ansible/facts.d/ansible_pip_path.fact
"/usr/local/lib/pyenv/shims/pip"
EOF

BINARY_LIST="ansible ansible-console ansible-doc ansible-galaxy ansible-playbook ansible-pull ansible-vault pip"

for binary in $BINARY_LIST; do
    [ -h "/usr/bin/$binary" ] || ln -s /usr/local/lib/pyenv/shims/$binary /usr/bin/$binary
done
