#!/bin/bash
#1 etcd 
if [ ! -n "$1"  ];then
    echo "请输入ip地址"
else

    info "正在安装 etcd.............................."
    sleep 1
    
    yum install etcd -y
    cp /data/k8s/conf/etcd/etcd.conf  /etc/etcd/
    mkdir /data/etcd  -p
    chown etcd:etcd /data/etcd/ -R
    systemctl restart etcd
    
    #2 k8s server
    cp /data/k8s/kubernetes/server/* /usr/bin
    
    #3 conf
    mkdir -p /etc/kubernetes/
    mkdir -p /data/kubelet
    cp -r /data/k8s/kubernetes/config/* /etc/kubernetes/
    #1) apiserver
    sed -i "s#KUBE_API_ADDRESS.*#KUBE_API_ADDRESS=\"--advertise-address=${ETHIP} --bind-address=${ETHIP} --insecure-bind-address=127.0.0.1\" #" /etc/kubernetes/kube-apiserver
    
    #2) kublet
    sed -i "s#NODE_ADDRESS.*#KUBE_API_ADDRESS=\"--advertise-address=${ETHIP} --bind-address=${ETHIP}\"#" /etc/kubernetes/kubelet
    sed -i "s#NODE_HOSTNAME.*#NODE_HOSTNAME=\"--hostname-override=${ETHIP}\"#" /etc/kubernetes/kubelet
    
    #3) proxy
    sed -i "s#NODE_HOSTNAME.*#NODE_HOSTNAME=\"--hostname-override=${ETHIP}\"#" /etc/kubernetes/proxy
    
    #4 system
    cp  /data/k8s/kubernetes/system/* /lib/systemd/system/
    
    #5 enable
    systemctl enable kube-apiserver.service
    systemctl enable kube-controller-manager.service
    systemctl enable kubelet
    systemctl enable kube-proxy
    systemctl enable kube-scheduler
    
    #6 start 
    
    systemctl restart kube-apiserver.service
    systemctl restart kube-controller-manager.service
    systemctl restart kubelet
    systemctl restart kube-proxy
    systemctl restart kube-scheduler
    
    #7 GPU
    sleep 5
    kubectl create -f /data/k8s/nvidia-device-plugin.yml
    
    #8 namespace
    kubectl create namespace linkingmed
    kubectl label node $1 env=local pref=high-priority processor=gpu
fi    







