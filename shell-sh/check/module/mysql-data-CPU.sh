#!/bin/sh
#author  lan.xiao@linkingmed.com
#date    2018-05-03 12:00
#1 创建数据库
MYSQL_DICOM=$(mysql -uroot -pLinkingmed2018@ -e "show databases;" | grep 'linkdicom'|wc -l)
MYSQL_OIS=$(mysql -uroot -pLinkingmed2018@ -e "show databases;" | grep 'linkingois'|wc -l)
MYSQL_MESSAGE=$(mysql -uroot -pLinkingmed2018@ -e "show databases;" | grep 'message'|wc -l)
DATABASE=/data/init_db
#load dicom
if [[ ${MYSQL_DICOM} -eq 1 ]];then
    echo "mysql-linkdicom is exists"
else
    mysql -uroot -p'Linkingmed2018@' -e "create database  linkdicom;"
    echo "load mysql-dicom"
    mysql -uroot -p'Linkingmed2018@' linkdicom   <${DATABASE}/dicom/dicom-2.0.11.4-init.sql
fi
#load ois
if [[ ${MYSQL_OIS} -eq 1 ]];then
    echo "mysql-ois is exists"
else
    mysql -uroot -p'Linkingmed2018@' -e "create database  linkingois;"
    echo "laod mysql-ois"
    mysql -uroot -p'Linkingmed2018@' linkingois  <${DATABASE}/ois/ois-2.1.0-20181009.sql
fi
#load message
if [[ ${MYSQL_DICOM} -eq 1 && ${MYSQL_OIS} -eq 1 && ${MYSQL_MESSAGE} -eq 1 ]];then
    echo "mysql-message is exists"
else
    mysql -uroot -p'Linkingmed2018@' -e "create database  message;"
    echo "load  mysql-message"
    mysql -uroot -p'Linkingmed2018@' message     <${DATABASE}/message/message_1.0.1_20180712.sql
fi
#mysql -uroot -p'Linkingmed2018@' <<EOF
#create database  linkdicom;
#grant all on linkdicom.* to  'linkdicom'@'%' identified by  'Linkdicom2018@';
#	
#create database  linkingois;
#grant all on linkingois.* to  'linkingois'@'%' identified by  'Linkingois2018@';
#
#create database  message;
#grant all on message.* to  'message'@'%' identified by  'message2018@';
#
#grant all on *.* to root@'%' identified by 'Linkingmed2018@';
#EOF
#
##2 导入初始数据
#DATABASE=/data/init_db
#echo "load dicom"
#mysql -uroot -p'Linkingmed2018@' linkdicom   <${DATABASE}/dicom/dicom-2.0.11.4-init.sql
#
#echo "load ois"
#mysql -uroot -p'Linkingmed2018@' linkingois  <${DATABASE}/ois/ois-2.1.0-20181009.sql
#
#echo "load message"
#mysql -uroot -p'Linkingmed2018@' message     <${DATABASE}/message/message_1.0.1_20180712.sql
#
#mysql -uroot -p'Linkingmed2018@' -e "show databases;"
#
