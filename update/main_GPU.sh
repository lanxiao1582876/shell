#!/bin/sh
#0 source 函数(all)
source /data/shell-sh/check/lib/function.sh
#1 source 自己的lib文件(all)
source /data/shell-sh/check/lib/basic.sh
source /data/update/base.sh
#2 升级sql
source /data/update/model/update_sql_GPU.sh
#3 升级工程包
source /data/update/model/linkone.sh
#4 shell-sh
source /data/update/model/shell.sh
#5 升级算法
source /data/update/model/alg.sh
#tmp
#1 docker
sed -i  's#ExecStart=.*#ExecStart=/usr/bin/dockerd --graph /data/docker -H tcp://0.0.0.0:2375 -H unix://var/run/docker.sock#' /lib/systemd/system/docker.service
systemctl  daemon-reload
systemctl  restart docker

#2 etcd k8s
systemctl stop etcd
systemctl stop kube-apiserver.service
systemctl stop kube-controller-manager.service
systemctl stop kubelet
systemctl stop kube-proxy
systemctl stop kube-scheduler

systemctl disable etcd
systemctl disable kube-apiserver.service
systemctl disable kube-controller-manager.service
systemctl disable kubelet
systemctl disable kube-proxy
systemctl disable kube-scheduler
#3 nfs
umount -f /alg/data/
systemctl stop nfs
systemctl disable nfs
sed -i '/nfs/d' /etc/fstab

#4 swap
echo "创建swap,时间较长"
dd if=/dev/zero of=/data/swapfile bs=1M count=16000
chmod 600 /data/swapfile
mkswap /data/swapfile
swapon /data/swapfile
sed -i "\$a /data/swapfile  /swap                   swap     defaults        0 0 "  /etc/fstab
free -h
echo "swap 启动成功"
