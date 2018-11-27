#!/bin/bash
# Install offline.repo
info 'offline.repo'
if [ -f /etc/yum.repos.d/offline.repo -a -d /data/base_ev/rpm-install ];then
  ok 'offline.repo已经存在'
else
  err 'offline.repo 不存在'
  install_offlinerepo
  yum install vim -y
fi

