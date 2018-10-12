#!/bin/bash
#use mysqldump to fully backup mysql data
 
BakDir=/data/db_bak/full
LogFile=/data/db_bak/full/fullbak.log
 
mkdir -p ${BakDir}
Date=$(date +%Y%m%d)
Begin=$(date +"[%F %T]")
cd $BakDir
DumpFile=$Date.sql.gz
/usr/bin/mysqldump -uroot -pLinkingmed2018@ --all-databases --lock-all-tables  | gzip > $DumpFile
Last=$(date +"[%F %T]")
echo "Start:$Begin End:$Last $DumpFile succ" >> $LogFile
