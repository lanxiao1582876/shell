#!/bin/bash
DATE=$(date +"%Y%m%d%H%M%S")
SQL_BAK=/data/bak/mysql_bak
LINKONE_SQL_DIR=/data/update/sql/linkone/linkone.sql 

MYSQLDUMP=$(mysqldump -uroot -p'Linkingmed2018@')
KU=linkone
#1 bak
mkdir ${SQL_BAK}  -p  

#2 linkone
if [[ -f ${LINKONE_SQL_DIR} ]];then
    info "升级${KU}数据库"
    #1 备份
    mysqldump -uroot -p'Linkingmed2018@' ${KU} >${SQL_BAK}/${KU}_bak_${DATE}.sql
    ok "${KU} 备份成功"
    #2 升级 
    mysql -uroot -p'Linkingmed2018@' ${KU} <${LINKONE_SQL_DIR}
    if [[ $? -eq 0 ]];then
        ok  "${KU} 数据库升级成功"
    else
        err "${KU} 数据库升级失败"
    fi
else
    info "不升级linkone数据库"
fi

