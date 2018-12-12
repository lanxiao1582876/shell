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
cp /data/shell-sh/system/link-dicom-api.service         /lib/systemd/system/
cp /data/shell-sh/system/link-dicom-archive.service     /lib/systemd/system/
cp /data/shell-sh/system/link-dicom-dcmsender.service   /lib/systemd/system/
cp /data/shell-sh/system/link-ois2.service              /lib/systemd/system/
cp /data/shell-sh/system/link-message.service           /lib/systemd/system/
cp /data/shell-sh/system/link-jasperserver.service      /lib/systemd/system/
systemctl daemon-reload
