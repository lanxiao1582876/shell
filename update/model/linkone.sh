#!/bin/sh
DATE=$(date +"%Y%m%d%H%M%S")
LINKONE_BAK=/data/bak/linkone
LINKONE_ZIP=/data/update/linkone.zip
LINKONE_DIR=/data/ois/site/backend/linkone
if [[ -f ${LINKONE_ZIP} ]];then
    info '更新linkone工程包'
    #1 bak
    mkdir -p ${LINKONE_BAK} 
    mv ${LINKONE_DIR} ${LINKONE_BAK}/linkone_bak_${DATE}
    ok 'linkone 工程包备份成功'
    #2 update
    unzip -q ${LINKONE_ZIP} -d /data
    cp -f ${LINKONE_BAK}/linkone_bak_${DATE}/.license ${LINKONE_DIR}
    ok '更新linkone工程包成功'
else
    info '不更新linkone工程包'    
fi

