#!/usr/bin/env bash
DISK=$(mount |grep "data type ext4"|awk '{print $1}')
FSTAB=/etc/fstab
SWAP="#/dev/"

#1
info "Disk mount Check"
if [ $(mount |grep "data type ext4"|wc -l) -eq 1 ];then
  ok $(mount |grep "data type ext4")
else
  err "Disk Mount ERROR!"
fi

#2
info "fstab Check"
if [ $(grep ${DISK} ${FSTAB}|wc -l) -eq 1 -a $(grep nfs ${FSTAB}|wc -l) -eq 1 -a $(grep ${SWAP} ${FSTAB}|wc -l) -eq 1  ];then
  ok $(grep ${DISK} /etc/fstab)
  ok $(grep nfs /etc/fstab)
  ok $(grep ${SWAP} /etc/fstab)
else
  err "fstab ERROR!!!"
fi
