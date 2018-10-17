#!/bin/sh

#1 
info  'Install oracle JDk'
rpm -qa | grep openjdk
[ $? -eq 0 ] && rpm -qa | grep openjdk | xargs rpm --nodeps -e
if [ -x "$(command -v java)" ];then
  ok 'java 已经安装'
else
  err 'java 没有安装'
  install_jdk 
fi

#2 
info  'Install 对比算法'
DCMTK=/data/software/dcmtk-gcc-4.8.5/bin/dsr2html
if [[ -d /data/anaconda3/ ]] || [[ -d /data/script/  ]] || [[ -f ${DCMTK} ]];then
  ok '对比算法已经安装'
else
  err '对比算法已经安装'
  cd /data
  if [[ -f duibi.alg.zip ]];then
    unzip duibi.alg.zip
    ok '对比算法 OK'
  else
    err 'duibi.alg.zip 不存在'
    exit
  fi
fi

#3
info 'python 依赖'
if [[ $(rpm -qa mesa-libGL mesa-libGL-devel|wc -l) -eq 2 ]];then
  ok 'python 依赖已经安装'
else
  err 'python 依赖没有安装'
  yum install mesa-libGL-devel mesa-libGLU-devel -y 
  ok 'python 依赖 OK'
fi

#4
info 'dicom 依赖'
DICOM_A=/usr/local/bin/libclib_jiio-1.2-b04-linux-x86-64.so
DICOM_B=/usr/lib64/libpng15.so.15
if [[ -f ${DICOM_A} ]];then
  ok "${DICOM_A} 依赖已经安装"
else
  err "${DICOM_A} 没有"
  cp /data/base_ev/dicom/libclib_jiio-1.2-b04-linux-x86-64.so /usr/local/bin 
  ok  "${DICOM_A} OK!!"
fi
if [[ -f ${DICOM_B} ]];then
  ok "${DICOM_B} 依赖已经安装"
else
  err "${DICOM_B} 没有"
  cp /data/base_ev/dicom/libpng15.so.15 /usr/lib64/ 
  ok  "${DICOM_B} OK!!"
fi

#5 
info 'nginx'
if [[ $(rpm -qa nginx |wc -l) -eq 1 ]];then
  ok 'nginx 已经安装'
else 
  err 'nginx 没有安装'
  install_nginx
fi

#6 
info 'rabbitmq'
if [[ $(rpm -qa rabbitmq-server|wc -l) -eq 1 ]];then
  ok 'rabbitmq 已经安装'
else
  err 'rabbitmq 没有安装'
  install_rabbitmq
fi

#7 
info "mysql"
if [[ $(rpm -qa mysql-community-server|wc -l) -eq 1 ]];then
  ok 'mysql 已经安装'
else
  err 'mysql 没有安装'
  install_mysql
fi


















