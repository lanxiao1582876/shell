#!/bin/sh

#1 
info  'Install oracle JDk'
rpm -qa | grep openjdk
[ $? -eq 0 ] && rpm -qa | grep openjdk | xargs rpm --nodeps -e
if [ -x "$(command -v java)" ];then
  ok 'java 已经安装'
else
  install_jdk 
fi

#2 
info  'Install 对比算法'
DCMTK=/data/software/dcmtk-gcc-4.8.5/bin/dsr2html
if [[ -d /data/anaconda3/ ]] || [[ -d /data/script/  ]] || [[ -f ${DCMTK} ]];then
  ok '对比算法已经安装'
else
  cd /data 
  unzip duibi.alg.zip
fi

#3
info 'python 依赖'
if [[ $(rpm -qa mesa-libGL mesa-libGL-devel|wc -l) -eq 2 ]];then
  ok 'python 依赖已经安装'
else
  yum install mesa-libGL-devel mesa-libGLU-devel -y 
fi

#4
info 'dicom 依赖'
DICOM_A=/usr/local/bin/libclib_jiio-1.2-b04-linux-x86-64.so
DICOM_B=/usr/lib64/libpng15.so.15
if [[ -f ${DICOM_A} ]];then
  ok 'dicom_a 依赖已经安装'
else
  cp /data/base_ev/dicom/libclib_jiio-1.2-b04-linux-x86-64.so /usr/local/bin 
fi
if [[ -f ${DICOM_B} ]];then
  ok 'dicom_b 依赖已经安装'
else
  cp /data/base_ev/dicom/libpng15.so.15 /usr/lib64/ 
fi


#5 
info 'nginx'
if [[ $(rpm -qa nginx |wc -l) -eq 1 ]];then
  ok 'nginx 已经安装'
else 
  install_nginx
fi

#6 
info 'rabbitmq'
if [[ $(rpm -qa rabbitmq-server|wc -l) -eq 1 ]];then
  ok 'rabbitmq 已经安装'
else
  install_rabbitmq
fi



















