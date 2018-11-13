#!/bin/bash
# ois-frontend
OIS_FRONT_CONF=/data/ois/site/frontend/ois/dist/LM_IP.js
if [ -f ${OIS_FRONT_CONF} ];then
  sed -i "s#OIS:.*#OIS: 'http://'+document.domain+':55001/',#g" ${OIS_FRONT_CONF}
  sed -i "s#viewer:.*#viewer: 'http://'+document.domain+':9091/\#/main/reader/2d/',#g" ${OIS_FRONT_CONF}
  sed -i "s#dicomArchive:.*#dicomArchive: 'http://'+document.domain+':56000/',#g"  ${OIS_FRONT_CONF}
  sed -i "s#dicomWebSocket:.*#dicomWebSocket: 'ws://'+document.domain+':58000/',#g" ${OIS_FRONT_CONF}
  sed -i "s#tps:.*#tps: 'http://' + document.domain + ':56000/',#g" ${OIS_FRONT_CONF}
  sed -i "s#dicomMessage:.*#dicomMessage: 'http://' + document.domain + ':9091/',#g" ${OIS_FRONT_CONF}
  ok "OIS_FRONT_CONF"
else
  err "${OIS_FRONT_CONF} is not exist"
fi

# ois-backend
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
  sed -i 's/^M//' ${OIS_BACKEND_CONF}
  #4)rabbitmq
  sed -i "s#spring.rabbitmq.host=.*#spring.rabbitmq.host=${1}#" ${OIS_BACKEND_CONF}
  #5)linkone
  if [ -n "$2" ];then
    sed -i "s#linkone.url=.*#linkone.url=http://${2}:57000#" ${OIS_BACKEND_CONF}
  else
    sed -i "s#linkone.url=.*#linkone.url=http://${1}:57000#" ${OIS_BACKEND_CONF}
  fi 
  sed -i 's///' ${OIS_BACKEND_CONF}
  ok "OIS_BACKEND_CONF"
else
  err "${OIS_BACKEND_CONF} is not exist"
fi
