#!/bin/bash
# Install k8s.repo
info 'k8s.repo'
if [ -f /etc/yum.repo.d/k8s.repo ]||[ -d /data/base_ev/rpm-install ];then
  ok 'k8s.repo已经存在'
else
  err 'k8s.repo 不存在'
  install_k8srepo
fi

