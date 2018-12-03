#!/bin/bash
DATE=$(date +"%Y%m%d%H%M%S")
OIS_BAK=/data/bak/ois
OIS_ZIP=/data/update/ois.zip
LINKONE_DIR=/data/ois/site/backend/linkone
LINKONE_BAK=/data/bak/linkone
LINKONE_DIR=/data/ois/site/backend/linkone
if [[ -d ${LINKONE_DIR} ]];then
    if [[ -f ${OIS_ZIP} ]];then
        info '更新ois工程包'
        #1 bak
        mkdir -p ${OIS_BAK}  
        mkdir -p ${LINKONE_BAK} 
        cp    -r ${LINKONE_DIR} ${LINKONE_BAK}/linkone_bak_${DATE}
        mv  /data/ois/  ${OIS_BAK}/ois_bak_${DATE}
        ok 'ois 备份成功'
        #2 update
        unzip -q ${OIS_ZIP} -d /data
        cp -r ${LINKONE_BAK}/linkone_bak_${DATE}  ${LINKONE_DIR}
        ok 'ois更新成功'
    else
        err "ois.zip 不存在 "
   fi
else
   if [[ -f ${OIS_ZIP} ]];then
        info '更新ois工程包'
        #1 bak
        mkdir -p ${OIS_BAK}
        mv  /data/ois/  ${OIS_BAK}/ois_bak_${DATE}
        ok 'ois 备份成功'
        #2 update
        unzip -q ${OIS_ZIP} -d /data
        ok 'ois更新成功'
    else
        err "ois.zip 不存在 "
    fi
fi
