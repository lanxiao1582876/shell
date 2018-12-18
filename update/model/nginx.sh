#!/bin/bash
if [[ -f ${NGINX_CONF_RAIK} ]];then
    #1 bak
    info  "更新nginx raik"
    mkdir -p ${NGINX_BAK}
    mv ${NGINX_DIR}/raic.conf ${NGINX_BAK}/nginx_raic_bak_${DATE}
    ok "nginx riak备份成功，备份目录在${NGINX_BAK}"
    #2 update
    cp ${NGINX_CONF_RAIK} ${NGINX_DIR}
    systemctl restart nginx
    ok "nginx raik更新成功"
else
    info  "nginx raik不更新"
fi 

if [[ -f ${NGINX_CONF_VIEWER} ]];then
    #1 bak
    info  "更新nginx viewer"
    mkdir -p ${NGINX_BAK}
    mv ${NGINX_DIR}/viewer-new.conf ${NGINX_BAK}/nginx_viewer_bak_${DATE}
    ok "nginx viewer备份成功，备份目录在${NGINX_BAK}"
    #2 update
    cp ${NGINX_CONF_VIEWER} ${NGINX_DIR}
    systemctl restart nginx
    ok "nginx viewer更新成功"
else
    info  "nginx viewer不更新"
fi 

