#!/bin/bash
BASE_EV_BAK=/data/bak/base_ev
BASE_EV_DIR=/data/base_ev
BASE_EV_ZIP=/data/update/base_ev.zip
if [[ -f ${BASE_EV_ZIP} ]];then
    #1 bak
    info  "更新base_ev"
    mkdir -p ${BASE_EV_BAK}
    mv ${BASE_EV_DIR} ${BASE_EV_BAK}/base_ev_bak_${DATE}
    ok "base_ev备份成功，备份目录在${BASE_EV_BAK}"
    #2 update
    unzip -q ${BASE_EV_ZIP} -d /data
    ok "base_ev更新成功"
else
    info  "base_ev不更新"
fi 

