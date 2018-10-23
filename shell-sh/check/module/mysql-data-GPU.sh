#!/bin/sh
#author  lan.xiao@linkingmed.com
#date    2018-05-03 12:00
#1 创建数据库
mysql -uroot -p'Linkingmed2018@' <<EOF
create database  linkone;
grant all on linkone.* to  'linkone'@'%' identified by  'Linkone2018@';

grant all on *.* to root@'%' identified by 'Linkingmed2018@';
EOF

#2 导入初始数据
DATABASE=/data/init_db
#linkone
echo "load linkone"
mysql -uroot -p'Linkingmed2018@' linkone     <${DATABASE}/linkone/linkone_2.0.4.1_alg_1.0.3.9.sql

mysql -uroot -p'Linkingmed2018@' -e "show databases;"
