#!/bin/sh
#1
info 'docker'
yum   install  docker-ce -y

#2 start 
mkdir -p /data/docker
cp -f /data/k8s/conf/docker/docker.service  /usr/lib/systemd/system/docker.service
systemctl daemon-reload
systemctl restart docker
systemctl enable docker
docker --version

#3 nvidia-docker  
yum install -y nvidia-docker2
nvidia-docker version
cp -f /data/k8s/conf/docker/daemon.json /etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker



#4 import image
info  '导入镜像(时间较长)'
docker load -i /data/k8s/docker-image/centos_python_segment.tar
docker load -i /data/k8s/docker-image/k8s-device-plugin.tar
docker load -i /data/k8s/docker-image/pod-infrastructure.tar

docker images


