#!/usr/bin/env bash
DISK=$(mount |grep "data type ext4"|awk '{print $1}')
FSTAB=/etc/fstab
SWAP="#/dev/"

#1
info "Disk mount Check"
if [ $(mount |grep "data type ext4"|wc -l) -eq 1 ];then
  ok $(mount |grep "data type ext4")
else
  err "磁盘没有挂载!  如果只有一个磁盘，忽略此条信息"
fi

#2
info "fstab Check"
if [ $(grep ${DISK} ${FSTAB}|wc -l) -eq 1 ];then
  ok $(grep ${DISK} /etc/fstab)
else
  err "fstab ERROR! 如果只有一个磁盘，忽略此条信息"
fi
