#!/bin/bash
#安装k8s的时候需要的配置 

#1 limit
sed -i '$i * hard  nofile   65536' /etc/security/limits.conf
sed -i '$i * soft  nofile   65536' /etc/security/limits.conf

#2 关闭swap
swapoff -a
sed -i 's$/dev/mapper/cl-swap$#/dev/mapper/cl-swap/$' /etc/fstab

#3 打开ip转发
echo 1 >/proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf

#4 修改主机名
hostname OIS-GPU
echo 'OIS-GPU' >/etc/hostname
sed -i '1s/$/ OIS-GPU/' /etc/hosts 
if [[ $(grep ${1} /etc/hosts  |wc -l) -eq 0 ]];then
  sed -i "\$a ${1}  OIS-GPU " /etc/hosts
else
  echo "${1} is already exist "
fi

