#!/bin/bash
info "install ois"
if [[ -d /data/ois ]];then
    ok "ois 已经安装"
else
    cd /data
    if [[ -f ois.zip ]];then
        unzip  ois.zip
        unzip  linkone.zip
    else
        err "ois.zip is not exists"
    fi
fi   
info "copy ois service"
cp /data/shell-sh/system/* /lib/systemd/system/
