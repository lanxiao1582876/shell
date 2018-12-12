#!/bin/sh

#0 (CPU)
info "Install 字体"
FONTS=/usr/share/fonts
if [[  $(ls /usr/share/fonts/|wc -l) -eq 39 ]];then
  ok "字体已经安装"
else
  err "字体没有安装"
  install_fonts
  ok "字体安装ok"
fi
#1 (CPU)
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

#2(CPU)
info ' install python 依赖'
if [[ $(rpm -qa mesa-libGL mesa-libGL-devel|wc -l) -eq 2 ]];then
  ok 'python 依赖已经安装'
else
  err 'python 依赖没有安装'
  yum install mesa-libGL-devel mesa-libGLU-devel -y 
  ok 'python 依赖 OK'
fi

#3(CPU)
info 'install dicom 依赖'
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

#4 (CPU)
info 'install  rabbitmq'
if [[ $(rpm -qa rabbitmq-server|wc -l) -eq 1 ]];then
  ok 'rabbitmq 已经安装'
else
  err 'rabbitmq 没有安装'
  install_rabbitmq
fi

#7 (CPU)
info "import mysql-CPU"
MYSQL_DICOM=$(mysql -uroot -pLinkingmed2018@ -e "show databases;" | grep 'linkdicom'|wc -l)
MYSQL_OIS=$(mysql -uroot -pLinkingmed2018@ -e "show databases;" | grep 'linkingois'|wc -l)
MYSQL_MESSAGE=$(mysql -uroot -pLinkingmed2018@ -e "show databases;" | grep 'message'|wc -l)
if [[ ${MYSQL_DICOM} -eq 1 && ${MYSQL_OIS} -eq 1 && ${MYSQL_MESSAGE} -eq 1 ]];then
  ok 'mysql-CPU 已经导入'
else
  err 'mysql-CPU 没有导入'
  /bin/sh  /data/shell-sh/check/module/mysql-data-CPU.sh 
  ok "mysql-CPU OK!!"
fi
