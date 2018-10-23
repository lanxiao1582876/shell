#!/bin/sh

#1 (all)
info  'Install oracle JDk'
rpm -qa | grep openjdk
[ $? -eq 0 ] && rpm -qa | grep openjdk | xargs rpm --nodeps -e
if [ -x "$(command -v java)" ];then
  ok 'java 已经安装'
else
  err 'java 没有安装'
  install_jdk 
fi

#2 (all)
info 'nginx'
if [[ $(rpm -qa nginx |wc -l) -eq 1 ]];then
  ok 'nginx 已经安装'
else 
  err 'nginx 没有安装'
  install_nginx
fi

#3 (all)
info "mysql"
if [[ $(rpm -qa mysql-community-server|wc -l) -eq 1 ]];then
  ok 'mysql 已经安装'
else
  err 'mysql 没有安装'
  install_mysql
fi
