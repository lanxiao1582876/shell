#!/bin/sh
#针对云端有域名的修改配置
source /data/shell-sh/check/lib/basic.sh
#1 ois-fronend
OIS_FRONT_CONF=/data/ois/site/frontend/ois/dist/LM_IP.js
if [ -f ${OIS_FRONT_CONF} ];then
  sed -i "s#viewer:.*#viewer: 'http://${2}/\#/main/reader/2d/',#g" ${OIS_FRONT_CONF}
  sed -i "s#dicomMessage:.*#dicomMessage: 'http://${2}/',#g" ${OIS_FRONT_CONF}
  sed -i "s#newViewer:.*#newViewer: 'http://${3}/#/main/contour/',#g" ${OIS_FRONT_CONF}
  ok "OIS_FRONT_CONF"
else
  err "${OIS_FRONT_CONF} is not exist"
fi

#2 viewer
VIEWER_CONF=/data/ois/site/frontend/viewer/index.html
if [ -f ${VIEWER_CONF} ];then
  sed -i "s#\s   window.backendDomain.*#    window.backendDomain = 'http://${2}/'#" ${VIEWER_CONF}
  sed -i "s#\s   window.wsDomain.*#    window.wsDomain = 'ws://${2}/'#" ${VIEWER_CONF}
  ok "VIEWER_CONF"
else
  err "${VIEWER_CONF} is not exist"
fi
#3 viewer-new
VIEWER_NEW_CONF=/data/ois/site/frontend/viewer-new/index.html
if [ -f ${VIEWER_NEW_CONF} ];then
  sed -i "s#window.serverUrl =.*#window.serverUrl = 'http://${3}'#" ${VIEWER_NEW_CONF}
  sed -i "s#window.ws = 'ws://.*/message-service/message'#window.ws = 'ws://${3}/message-service/message'#" ${VIEWER_NEW_CONF} 
  ok  "VIEWER_NEW_CONF"
else
  err  "${VIEWER_NEW_CONF} is not exist"
fi

#4 dicom-api
API_CONF=/data/ois/site/backend/dicom/api/application-local.properties
if [ -f ${API_CONF} ];then
  sed -i  "s#storage.local.endpoint=.*#storage.local.endpoint=http://${2}#" ${API_CONF}
  ok "API_CONF"
else
  err "${API_CONF} is not exist"
fi
#5 dicom-archive
ARCHIVE_CONF=/data/ois/site/backend/dicom/archive/application-local.properties
if [ -f ${ARCHIVE_CONF} ];then
  sed -i "s#storage.local.endpoint=.*#storage.local.endpoint=http://${2}#" ${ARCHIVE_CONF}
  ok "ARCHIVE_CONF"
else
  err "${ARCHIVE_CONF} is not exist"
fi
#6 linkone
WAIWANG=$(curl http://members.3322.org/dyndns/getip)
LINKONE_CONF=/data/ois/site/backend/linkone/application-local.properties
LINKONE_CONF_A=/data/ois/site/backend/linkone/application.properties
if [ -f ${LINKONE_CONF} ];then
  sed -i "s#cluster.nfs.server.*#cluster.nfs.server=${WAIWANG}#"  ${LINKONE_CONF}
  sed -i "s#cluster.k8s.master.url=.*#cluster.k8s.master.url=https://139.219.11.234:6443#"   ${LINKONE_CONF}
  ok "LINKONE_CONF"
else
  err "${LINKONE_CONF} is not exist"
fi

#7 ois-backend
OIS_BACKEND_CONF=/data/ois/site/backend/ois/linkingOIS2/config/application-prod.properties
if [ -f ${OIS_BACKEND_CONF} ];then
  sed -i "s#download.*#download.file.machine.ip=http://${1}#" ${OIS_BACKEND_CONF}
  ok "OIS_BACKEND_CONF"
else
  err "${OIS_BACKEND_CONF} is not exist"
fi

#8 nginx
cd /etc/nginx/conf.d
cp -f viewer-new.conf.bak viewer-new.conf
cp -f raic.conf.bak  raic.conf
nginx -s reload
echo "远端关闭智能勾画"
