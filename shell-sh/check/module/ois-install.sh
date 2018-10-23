#!/bin/bash
info "install ois"
JAR_OIS=/data/ois/site/backend/ois
JAR_DICOM=/data/ois/site/backend/dicom
JAR_MESSAGE=/data/ois/site/backend/message

if [[ -d ${JAR_OIS} && -d ${JAR_DICOM} && -d ${JAR_MESSAGE} ]];then
    ok "ois 已经安装"
else
    cd /data
    if [[ -f ois.zip ]];then
        unzip  ois.zip
    else
        err "ois.zip is not exists"
    fi
fi   
info "copy ois service"
cp /data/shell-sh/system/* /lib/systemd/system/
systemctl daemon-reload
