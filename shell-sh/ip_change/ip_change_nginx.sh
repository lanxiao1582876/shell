#!/bin/bash
NGINX_CONF=/etc/nginx/conf.d/raic.conf
NGINC_VIEWER_CONF=/etc/nginx/conf.d/viewer-new.conf
# nginx
if [ -f ${NGINX_CONF} ];then
  sed -i "s#server_name.*#server_name ${1};#g" ${NGINX_CONF}
  ok "NGINX_CONF"
else
  err "${NGINX_CONF} is not exist"
fi
nginx -s reload

if [ -f ${NGINC_VIEWER_CONF} ];then
  sed -i "s#server_name.*#server_name ${1};#g" ${NGINC_VIEWER_CONF}
  ok "NGINX_VIEWER_CONF"
else
  err "${NGINC_VIEWER_CONF} is not exist"
fi
nginx -s reload
