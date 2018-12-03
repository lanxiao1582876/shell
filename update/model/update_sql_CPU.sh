#!/bin/bash
DATE=$(date +"%Y%m%d%H%M%S")
SQL_BAK=/data/bak/mysql_bak
OIS_SQL_DIR=/data/update/sql/ois/ois.sql 
DICOM_SQL_DIR=/data/update/sql/dicom/dicom.sql 

MYSQLDUMP=$(/usr/bin/mysqldump -uroot -p'Linkingmed2018@')

#1 bak
mkdir ${SQL_BAK}  -p  

#2 ois
if [[ -f ${OIS_SQL_DIR} ]];then
    info "升级ois数据库"
    #1 备份
    /usr/bin/mysqldump -uroot -p'Linkingmed2018@' linkingois >${SQL_BAK}/ois_bak_${DATE}.sql
    ok 'ois备份成功'
    #2 升级 
    /usr/bin/mysql -uroot -p'Linkingmed2018@' linkingois <${OIS_SQL_DIR}
    if [[ $? -eq 0 ]];then
        ok  'ois 数据库升级成功'
    else
        err 'ois 数据库升级失败'
    fi
else
    info '不升级ois数据库'
fi

#3 dicom
if [[ -f ${DICOM_SQL_DIR} ]];then
    info "升级dicom数据库"
    #1 备份
    /usr/bin/mysqldump -uroot -p'Linkingmed2018@' linkdicom >${SQL_BAK}/dicom_bak_${DATE}.sql
    ok 'dicom 备份成功'
    #2 升级 
    /usr/bin/mysql -uroot -p'Linkingmed2018@'  linkdicom <${DICOM_SQL_DIR}
    if [[ $? -eq 0 ]];then
        ok  'dicom 数据库升级成功'
    else
        err 'dicom 数据库升级失败'
    fi
else
    info '不升级dicom数据库'
fi

