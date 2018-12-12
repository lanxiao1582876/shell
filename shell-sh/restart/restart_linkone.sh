#!/bin/sh
ok()   { echo -e "\033[42;37m[  OK ]\033[0m $(date +"[%F %T]") $@";}
err()  { echo -e "\033[41;37m[ERROR]\033[0m $(date +"[%F %T]") $@" >&2; }

#重启linone所有服务脚本

##1 重启etcd
#systemctl restart etcd 
#if [[ $? -eq 0  ]];then
#  ok etcd  
#else
#  err etcd
#fi
##等待5s
#ok sleep 5
#
##2 重启k8 api
#systemctl restart kube-apiserver 
#if [[ $? -eq 0  ]];then
#  ok kube-apiserver
#else
#  err kube-apiserver
#fi

#3 重启linkone
#kill linkone
KILL_LINONE=$(ps -ef | grep linkone | grep -v grep | awk '{print $2}' |wc -l)
if [[ ${KILL_LINONE} -eq 0 ]];then
  echo ""
else
  ps -ef | grep linkone | grep -v grep | awk '{print $2}' | xargs kill -9
fi
#启动
sleep 1
systemctl restart link-linkone.service
if [[ $? -eq 0  ]];then
  ok link-linkone.service 
else
  err link-linkone.service
fi

#4 开机启动
systemctl enable link-linkone.service
