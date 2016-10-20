#!/usr/bin/env bash

set -e
set -x

FM_CONF_FILE="/etc/yum/pluginconf.d/fastestmirror.conf"
FM_TIMED_HOSTS="/var/cache/yum/timedhosts.txt"

function yum_based_lsb_install {
    which yum \
    && ( [ ! -e "$FM_CONF_FILE" ]   || sed -i -e 's/enabled=1/enabled=0/' $FM_CONF_FILE ) \
    && ( [ ! -e "$FM_TIMED_HOSTS" ] || rm -f $FM_TIMED_HOSTS ) \
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