#!/bin/bash

#删除30天以前的备份数据库

find /data/db_bak/full/ -mtime +30 -name "[0-9]*.sql.gz" |xargs rm -rf

