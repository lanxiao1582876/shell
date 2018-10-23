#!/bin/bash
info "install ois"
JAR_LINKONE=/data/ois/site/backend/linkone
BAG_LINKONE=linkone.zip
if [[ -d ${JAR_LINKONE} ]];then
    ok "linkone 已经安装"
else
    cd /data
    if [[ -f ${BAG_LINKONE} ]];then
        unzip  ${BAG_LINKONE}
    else
        err "${BAG_LINKONE} is not exists"
    fi
fi   
info "copy ois service"
cp /data/shell-sh/system/* /lib/systemd/system/
systemctl daemon-reload
