#!/bin/sh
FONTS_BAK=/data/bak/fonts
FONTS_DIR=/data/fonts
FONTS_ZIP=/data/update/fonts.zip
if [[ -f ${FONTS_ZIP} ]];then
    echo  "更新fonts"
    yum install fontconfig -y
    unzip -qo /data/base_ev/fonts-install/fonts.zip -d /usr/share/
    cd /usr/share/
    fc-cache -fv
    echo "fonts更新成功"
else
    echo  "fonts不更新"
fi
