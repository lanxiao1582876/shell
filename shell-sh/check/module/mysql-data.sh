#!/bin/sh
#author  lan.xiao@linkingmed.com
#date    2018-05-03 12:00

#1 修改密码
PASS=$(grep 'temporary password' /var/log/mysqld.log | tail -1 |awk '{print $NF}')
/usr/bin/mysql -uroot -p${PASS} --connect-expired-password <<EOF
set global validate_password_policy = 0;
SET PASSWORD = PASSWORD('Linkingmed2018@');
grant all privileges on *.* to root@'%' identified by 'Linkingmed2018@';
EOF

sleep 1
#2 创建数据库
mysql -uroot -p'Linkingmed2018@' -e "show databases;"
mysql -uroot -p'Linkingmed2018@' <<EOF
create database  linkdicom;
grant all on linkdicom.* to  'linkdicom'@'%' identified by  'Linkdicom2018@';
	
create database  linkingois;
grant all on linkingois.* to  'linkingois'@'%' identified by  'Linkingois2018@';

create database  linkone;
grant all on linkone.* to  'linkone'@'%' identified by  'Linkone2018@';
show databases;
grant all on *.* to root@'%' identified by 'Linkingmed2018@';
EOF

#3 导入初始数据
#dicom
mysql -uroot -p'Linkingmed2018@' linkdicom   <database/dicom/linkdicom_2.0.1.4.sql 

#linkone
mysql -uroot -p'Linkingmed2018@' linkone     <database/linkone/linkone.sql
mysql -uroot -p'Linkingmed2018@' linkone     <database/linkone/linkone_increment.sql

#ois
mysql -uroot -p'Linkingmed2018@' linkingois  <database/ois/RAIC2.0.13.sql

