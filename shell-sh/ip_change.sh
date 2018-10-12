#!/bin/bash
#修改现有ois系统的所有配置

#1 ip
#read -p '请输入本机ip地址: ' IP
#echo "ip: ${1}" 
err() {
  echo "[ERROR]...[$(date +'%F %T')]": $@ 2>&1
}
success() {
  echo "[SUCCESS]...[$(date +'%F %T')]": $@ 
}

NGINX_CONF=/etc/nginx/conf.d/raic.conf
NGINC_VIEWER_CONF=/etc/nginx/conf.d/viewer-new.conf
if [ ! -n "$1"  ];then
    echo "请输入ip地址"
else

    #2 nginx
    if [ -f ${NGINX_CONF} ];then
      sed -i "s#server_name.*#server_name ${1};#g" ${NGINX_CONF}
      success "NGINX_CONF"
    else 
      err "${NGINX_CONF} is not exist"
    fi
    nginx -s reload

    if [ -f ${NGINC_VIEWER_CONF} ];then
      sed -i "s#server_name.*#server_name ${1};#g" ${NGINC_VIEWER_CONF}
      success "NGINX_VIEWER_CONF"
    else
      err "${NGINC_VIEWER_CONF} is not exist"
    fi
    nginx -s reload

    #3 ois-frontend
    OIS_FRONT_CONF=/data/ois/site/frontend/ois/dist/LM_IP.js
    if [ -f ${OIS_FRONT_CONF} ];then
      sed -i "s#OIS:.*#OIS: 'http://'+document.domain+':55001/',#g" ${OIS_FRONT_CONF} 
      sed -i "s#viewer:.*#viewer: 'http://'+document.domain+':9091/\#/main/reader/2d/',#g" ${OIS_FRONT_CONF} 
      sed -i "s#dicomArchive:.*#dicomArchive: 'http://${1}:56000/',#g"  ${OIS_FRONT_CONF}
      sed -i "s#dicomWebSocket:.*#dicomWebSocket: 'ws://${1}:58000/',#g" ${OIS_FRONT_CONF}
      success "OIS_FRONT_CONF"
    else
      err "${OIS_FRONT_CONF} is not exist"
    fi
    
    #4 viewer
    VIEWER_CONF=/data/ois/site/frontend/viewer/index.html
    if [ -f ${VIEWER_CONF} ];then
      sed -i "s#\s   window.backendDomain.*#    window.backendDomain = 'http://'+document.domain+':9091/'#" ${VIEWER_CONF} 
      sed -i "s#\s   window.wsDomain.*#    window.wsDomain = 'ws://'+document.domain+':9091/'#" ${VIEWER_CONF} 
      success "VIEWER_CONF"
    else
      err "${VIEWER_CONF} is not exist"
    fi
    #4-1 viewer-new
    VIEWER_NEW_CONF=/data/ois/site/frontend/viewer-new/index.html
    if [ -f ${VIEWER_NEW_CONF} ];then
      sed -i "s#// window.serverUrl = 'http://test.viewer.linkingmed.com'#window.serverUrl = 'http://'+document.domain+':9093'#" ${VIEWER_NEW_CONF}
      sed -i "s#// window.ws = 'ws://test.viewer.linkingmed.com/message-service/message'#window.ws = 'ws://'+document.domain+':9093/message-service/message'#" ${VIEWER_NEW_CONF}
      success  "VIEWER_NEW_CONF"
    else
      err  "${VIEWER_NEW_CONF} is not exist"
    fi
    
    #5 ois-backend
    OIS_BACKEND_CONF=/data/ois/site/backend/ois/linkingOIS2/config/application-prod.properties
    if [ -f ${OIS_BACKEND_CONF} ];then
      #1)mysql
      sed -i 's#spring.datasource.url.*#spring.datasource.url=jdbc:mysql://127.0.0.1:3306/linkingois?useUnicode=true\&characterEncoding=UTF-8#' ${OIS_BACKEND_CONF} 
      sed -i 's#spring.datasource.username.*#spring.datasource.username=root#' ${OIS_BACKEND_CONF} 
      sed -i 's#spring.datasource.password.*#spring.datasource.password=Linkingmed2018@#' ${OIS_BACKEND_CONF} 
      #2)download
      sed -i "s#download.*#download.file.machine.ip=http://${1}:8888#" ${OIS_BACKEND_CONF} 
      #3)api archive
      sed -i "s#dicom-api.url=.*#dicom-api.url=http://127.0.0.1:56000#"  ${OIS_BACKEND_CONF}
      sed -i "s#dicom-archive.url=.*#dicom-archive.url=http://127.0.0.1:56001#" ${OIS_BACKEND_CONF}
      sed -i 's///' ${OIS_BACKEND_CONF}
      #4)rabbitmq
      sed -i "s#spring.rabbitmq.host=.*#spring.rabbitmq.host=${1}#" ${OIS_BACKEND_CONF}
      success "OIS_BACKEND_CONF"
    else
      err "${OIS_BACKEND_CONF} is not exist"
    fi
    
    #6 dicom-api
    API_CONF=/data/ois/site/backend/dicom/api/application-local.properties
    if [ -f ${API_CONF} ];then
      #1)mode
      sed -i "s#^mode.*#mode = local#" ${API_CONF}
      #2)mysql
      sed -i 's#spring.datasource.url.*#spring.datasource.url=jdbc:mysql://127.0.0.1:3306/linkdicom?useUnicode=true\&amp;characterEncoding=utf-8#' ${API_CONF}
      sed -i 's#spring.datasource.username.*#spring.datasource.username=root#' ${API_CONF}
      sed -i 's#spring.datasource.password.*#spring.datasource.password=Linkingmed2018@#' ${API_CONF}
      #3)fileUrlBase
      sed -i "s#fileUrlBase.*#fileUrlBase=/local_archive#" ${API_CONF} 
      #4) passport
      sed -i "s#^passport.auth.endpoint=.*#passport.auth.endpoint=http://${1}:55001#" ${API_CONF}
      #5)linkone
      sed -i "s#^linkone.service.endpoint=.*#linkone.service.endpoint=http://${1}:57000#" ${API_CONF}
      #6) mq
      sed -i  "s#spring.rabbitmq.host=.*#spring.rabbitmq.host=${1}#" ${API_CONF}
      #7) endpoint
      sed -i  "s#storage.local.endpoint=.*#storage.local.endpoint=http://${1}:9091#" ${API_CONF}
      
    
      sed -i 's///' ${API_CONF} 
      success "API_CONF"
    else
      err "${API_CONF} is not exist"
    fi
    #
    #7 dicom-archive
    ARCHIVE_CONF=/data/ois/site/backend/dicom/archive/application-local.properties
    if [ -f ${ARCHIVE_CONF} ];then
      #1) model
      sed -i "s#^mode.*#mode = local#"  ${ARCHIVE_CONF}
      #2)mysql
      sed -i 's#spring.datasource.url.*#spring.datasource.url=jdbc:mysql://127.0.0.1:3306/linkdicom?useUnicode=true\&amp;characterEncoding=utf-8#' ${ARCHIVE_CONF}
      sed -i 's#spring.datasource.username.*#spring.datasource.username=root#' ${ARCHIVE_CONF}
      sed -i 's#spring.datasource.password.*#spring.datasource.password=Linkingmed2018@#' ${ARCHIVE_CONF}
      #3)file url
      sed -i "s#storage.local.fileUrlBase.*#storage.local.fileUrlBase=/local_archive#" ${ARCHIVE_CONF}
      sed -i "s#storage.local.endpoint=.*#storage.local.endpoint=http://${1}:9091#" ${ARCHIVE_CONF}
    
      sed -i 's///' ${ARCHIVE_CONF} 
      success "ARCHIVE_CONF"
    else
      err "${ARCHIVE_CONF} is not exist"
    fi
    
    #8 message
    MESSAGE_CONF=/data/ois/site/backend/message/application-local.properties
    if [ -f ${MESSAGE_CONF} ];then
      #1) mysql
      sed -i 's#spring.datasource.url.*#spring.datasource.url=jdbc:mysql://127.0.0.1:3306/message?useUnicode=true\&amp;characterEncoding=utf-8#' ${MESSAGE_CONF} 
      sed -i 's#spring.datasource.username.*#spring.datasource.username=root#' ${MESSAGE_CONF}
      sed -i 's#spring.datasource.password.*#spring.datasource.password=Linkingmed2018@#' ${MESSAGE_CONF}
      #2) mq
      sed -i "s#spring.rabbitmq.host.*#spring.rabbitmq.host=${1}#" ${MESSAGE_CONF} 
      #3) passport
      sed -i "s#passport.auth.loginURL.*#passport.auth.loginURL = http://${1}:55001/raicois/api/v2/login#" ${MESSAGE_CONF}
      sed -i 's///' ${MESSAGE_CONF}
      success "MESSAGE_CONF"
    else
      err "${MESSAGE_CONF} is not exist"
    fi
    
    #9 dicom-dcmsender
    DCMSENDER_CONF=/data/ois/site/backend/dicom/dcmsender/application-local.properties
    if [ -f ${DCMSENDER_CONF} ];then
      #1) mysql
      sed -i 's#spring.datasource.url.*#spring.datasource.url=jdbc:mysql://127.0.0.1:3306/linkdicom?useUnicode=true\&amp;characterEncoding=utf-8#' ${DCMSENDER_CONF}
      sed -i 's#spring.datasource.username.*#spring.datasource.username=root#' ${DCMSENDER_CONF}
      sed -i 's#spring.datasource.password.*#spring.datasource.password=Linkingmed2018@#' ${DCMSENDER_CONF}
      #2) mq
      sed -i "s#spring.rabbitmq.host.*#spring.rabbitmq.host=${1}#" ${DCMSENDER_CONF}
      sed -i 's///' ${DCMSENDER_CONF}
      success "DCMSENDER_CONF"
    else
      err "${DCMSENDER_CONF} is not exist"
    fi


    #10 linkone
    LINKONE_CONF=/data/ois/site/backend/linkone/application-local.properties
    if [ -f ${LINKONE_CONF} ];then
      #1) mysql
      sed -i 's#spring.datasource.url.*#spring.datasource.url=jdbc:mysql://127.0.0.1:3306/linkone?useUnicode=true\&amp;characterEncoding=utf-8#' ${LINKONE_CONF} 
      sed -i 's#spring.datasource.username.*#spring.datasource.username=root#' ${LINKONE_CONF}
      sed -i 's#spring.datasource.password.*#spring.datasource.password=Linkingmed2018@#' ${LINKONE_CONF}
      #2) mq
      sed -i "s#spring.rabbitmq.host=.*#spring.rabbitmq.host=${1}#"  ${LINKONE_CONF}
      #3) nfs
      sed -i "s#cluster.nfs.server.*#cluster.nfs.server=${1}#"  ${LINKONE_CONF}
      #4) k8s
      sed -i "s#cluster.k8s.master.url=.*#cluster.k8s.master.url=https://${1}:6443#" ${LINKONE_CONF}
      #5) etcd
      sed -i "s#cluster.k8s.etcd.url=.*#cluster.k8s.etcd.url=http://${1}:2379#" ${LINKONE_CONF}
      #6) mode
      sed -i "s#storage.mode.*#storage.mode=local#" ${LINKONE_CONF}
      #7) url
      sed -i "s#storage.urlBase.*#storage.urlBase=http://${1}:9092#" ${LINKONE_CONF}
      #8)
      sed -i "s#cluster.alg.notifyUrl=.*#cluster.alg.notifyUrl=http://${1}:57000/task/events/add#" ${LINKONE_CONF}
      sed -i 's///' ${LINKONE_CONF}
      success "LINKONE_CONF"
    else
      err "${LINKONE_CONF} is not exist"
    fi
fi    
