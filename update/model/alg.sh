#!/bin/bash
if [[ -f ${ALG_ZIP} ]];then
    #1 bak
    info  "更新算法"
    mkdir -p ${ALG_BAK}
    mv ${ALG_DRI} ${ALG_BAK}/alg_bak_${DATE}
    ok "算法备份成功，备份目录在${ALG_BAK}"
    #2 update
    unzip -q ${ALG_ZIP} -d /data
    ok "算法更新成功"
else
    info  "算法不更新"
fi 

