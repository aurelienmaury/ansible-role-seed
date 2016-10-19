#!/usr/bin/env bash

set -e
set -x

function yum_based_lsb_install {
    which yum \
    && sed -i -e 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf  \
    && rm -f /var/cache/yum/timedhosts.txt \
    && sleep 2 \
    && yum makecache -y \
    && yum install redhat-lsb-core -y
}

function apt_based_lsb_install {
    which apt-get \
    && apt-get update \
    && apt-get install lsb-release -y
}

yum_based_lsb_install || apt_based_lsb_install