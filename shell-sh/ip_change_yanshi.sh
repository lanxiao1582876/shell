#!/bin/bash
#迁移
#1 k8s
#1) apiserver
sed -i "s#KUBE_API_ADDRESS.*#KUBE_API_ADDRESS=\"--advertise-address=${1} --bind-address=${1} --insecure-bind-address=127.0.0.1\" #" /etc/kubernetes/kube-apiserver

#2) kublet
sed -i "s#NODE_ADDRESS.*#KUBE_API_ADDRESS=\"--advertise-address=${1} --bind-address=${1}\"#" /etc/kubernetes/kubelet
sed -i "s#NODE_HOSTNAME.*#NODE_HOSTNAME=\"--hostname-override=${1}\"#" /etc/kubernetes/kubelet

#3) proxy
sed -i "s#NODE_HOSTNAME.*#NODE_HOSTNAME=\"--hostname-override=${1}\"#" /etc/kubernetes/proxy
#4) restart 
systemctl restart kube-apiserver.service
systemctl restart kube-controller-manager.service
systemctl restart kubelet
systemctl restart kube-proxy
systemctl restart kube-scheduler
sleep 10
kubectl create -f /data/k8s/nvidia-device-plugin.yml
kubectl create namespace linkingmed
kubectl label node $1 env=local pref=high-priority processor=gpu

#2 nfs
umount -f /alg/data/
systemctl restart nfs
sleep 3
mount ${1}:/data/alg/run/ /alg/data/
if [ $(grep ${1} /etc/fstab|wc -l ) -eq 0 ];then
  sed -i "s#.*/alg/data.*#${1}:/data/alg/run  /alg/data            nfs     defaults        0 0#" /etc/fstab
else
  echo "nfs is already in /etc/fstab"
fi
