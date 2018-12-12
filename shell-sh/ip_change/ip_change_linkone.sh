#!/bin/bash
#10 linkone
source /data/shell-sh/check/lib/basic.sh
LINKONE_CONF=/data/ois/site/backend/linkone/application-local.properties
LINKONE_CONF_A=/data/ois/site/backend/linkone/application.properties
if [ -f ${LINKONE_CONF} ];then
  #0)local
  sed -i 's#spring.*#spring.profiles.active=local#' ${LINKONE_CONF_A} 
  #1) mysql
  sed -i 's#spring.datasource.url.*#spring.datasource.url=jdbc:mysql://127.0.0.1:3306/linkone?useUnicode=true\&amp;characterEncoding=utf-8#' ${LINKONE_CONF}
  sed -i 's#spring.datasource.username.*#spring.datasource.username=root#' ${LINKONE_CONF}
  sed -i 's#spring.datasource.password.*#spring.datasource.password=Linkingmed2018@#' ${LINKONE_CONF}
  #2) mq
  if [ -n "$2" ];then
    sed -i "s#spring.rabbitmq.host=.*#spring.rabbitmq.host=${2}#"  ${LINKONE_CONF}
  else
    sed -i "s#spring.rabbitmq.host=.*#spring.rabbitmq.host=${1}#"  ${LINKONE_CONF}
  fi
  #3) nfs
  sed -i "s#cluster.nfs.server.*#cluster.nfs.server=${1}#"  ${LINKONE_CONF}
  #4) k8s
  sed -i "s#cluster.k8s.master.url=.*#cluster.k8s.master.url=https://${1}:6443#"   ${LINKONE_CONF}
  sed -i 's#cluster.k8s.namespace=.*#cluster.k8s.namespace=linkingmed#'            ${LINKONE_CONF}
  sed -i 's#cluster.k8s.ca.crt=.*#cluster.k8s.ca.crt=/etc/kubernetes/ca/ca.pem#'   ${LINKONE_CONF}
  sed -i 's#cluster.k8s.client.crt=.*#cluster.k8s.client.crt=/etc/kubernetes/ca/kubernetes.pem#'  ${LINKONE_CONF}
  sed -i 's#cluster.k8s.client.key=.*#cluster.k8s.client.key=/etc/kubernetes/ca/kubernetes-key.pem#'  ${LINKONE_CONF}
  
  sed -i 's#cluster.job.delete=.*#cluster.job.delete=true#'  ${LINKONE_CONF}
  #5) etcd
  sed -i "s#cluster.k8s.etcd.url=.*#cluster.k8s.etcd.url=http://${1}:2379#" ${LINKONE_CONF}
  #6) mode
  sed -i "s#storage.mode.*#storage.mode=local#" ${LINKONE_CONF}
  #7) url
  sed -i "s#storage.urlBase.*#storage.urlBase=http://${1}:9092#" ${LINKONE_CONF}
  #8)
  sed -i "s#cluster.alg.notifyUrl=.*#cluster.alg.notifyUrl=http://${1}:57000/task/events/add#" ${LINKONE_CONF}
  #9)docker
  sed -i "s#cluster.docker.url=.*#cluster.docker.url=http://${1}:2375#" ${LINKONE_CONF}

  sed -i 's///' ${LINKONE_CONF}
  ok "LINKONE_CONF"
else
  err "${LINKONE_CONF} is not exist"
fi

