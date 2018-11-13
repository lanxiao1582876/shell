#!/bin/bash
#1 dicom-api
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
  if [ -n "$2" ];then
    sed -i "s#^linkone.service.endpoint=.*#linkone.service.endpoint=http://${2}:57000#" ${API_CONF}
  else
    sed -i "s#^linkone.service.endpoint=.*#linkone.service.endpoint=http://${1}:57000#" ${API_CONF}
  fi
  #6) mq
  sed -i  "s#spring.rabbitmq.host=.*#spring.rabbitmq.host=${1}#" ${API_CONF}
  #7) endpoint
  sed -i  "s#storage.local.endpoint=.*#storage.local.endpoint=http://${1}:9091#" ${API_CONF}

  sed -i 's///' ${API_CONF}
  ok "API_CONF"
else
  err "${API_CONF} is not exist"
fi

#2 dicom-archive
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
  ok "ARCHIVE_CONF"
else
  err "${ARCHIVE_CONF} is not exist"
fi

#3 dicom-dcmsender
DCMSENDER_CONF=/data/ois/site/backend/dicom/dcmsender/application-local.properties
if [ -f ${DCMSENDER_CONF} ];then
  #1) mysql
  sed -i 's#spring.datasource.url.*#spring.datasource.url=jdbc:mysql://127.0.0.1:3306/linkdicom?useUnicode=true\&amp;characterEncoding=utf-8#' ${DCMSENDER_CONF}
  sed -i 's#spring.datasource.username.*#spring.datasource.username=root#' ${DCMSENDER_CONF}
  sed -i 's#spring.datasource.password.*#spring.datasource.password=Linkingmed2018@#' ${DCMSENDER_CONF}
  #2) mq
  sed -i "s#spring.rabbitmq.host.*#spring.rabbitmq.host=${1}#" ${DCMSENDER_CONF}
  sed -i "s#passport.auth.endpoint=.*#passport.auth.endpoint=http://${1}:55001#" ${DCMSENDER_CONF}
  sed -i 's///' ${DCMSENDER_CONF}
  ok "DCMSENDER_CONF"
else
  err "${DCMSENDER_CONF} is not exist"
fi

#4 message
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
  ok "MESSAGE_CONF"
else
  err "${MESSAGE_CONF} is not exist"
fi
