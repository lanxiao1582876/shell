#!/bin/sh
#0
info "import mysql-GPU"
MYSQL_LINKONE=$(mysql -uroot -pLinkingmed2018@ -e "show databases;" | grep 'linkone'|wc -l)
if [[ ${MYSQL_LINKONE} -eq 1 ]];then
  ok 'mysql-GPU 已经导入'
else
  err 'mysql-GPU 没有导入'
  /bin/sh  /data/shell-sh/check/module/mysql-data-GPU.sh 
  ok "mysql-GPU OK!!"
fi

#1
info  "install docker"
if [[ $(rpm -qa docker-ce|wc -l) -eq 1 ]];then
  ok 'docker 已经安装'
else
  err 'docker 没有安装'
  install_docker
fi

#2 
info  "install k8s"
if [[ $(ls -l /lib/systemd/system/kube*|wc -l) -eq 5 ]];then
  ok 'k8s 已经安装'
else
  err 'k8s 没有安装'
  install_k8s ${1}
fi

#3
info "install nfs"
if [[ $(rpm -qa nfs-utils|wc -l) -eq 1 ]];then
  ok "nfs 已经安装"
else
  err "nfs 没有安装"
  install_nfs ${1}
fi

