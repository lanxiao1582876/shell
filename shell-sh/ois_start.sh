#!/bin/sh
ok()   { echo -e "\033[42;37m[  OK ]\033[0m $(date +"[%F %T]") $@";}
err()  { echo -e "\033[41;37m[ERROR]\033[0m $(date +"[%F %T]") $@" >&2; }

#启动ois所有服务脚本

#1重启 link-ois2.service
systemctl restart link-ois2.service
if [[ $? -eq 0  ]];then
  ok link-ois2.service
else
  err link-ois2.service
fi
#2 重启link-dicom-api.service
systemctl restart link-dicom-api.service
if [[ $? -eq 0  ]];then
  ok link-dicom-api.service
else
  err link-dicom-api.service
fi
#3 重启link-dicom-archive.service
systemctl restart link-dicom-archive.service
if [[ $? -eq 0  ]];then
  ok link-dicom-archive.service
else
  err link-dicom-api.service
fi

#4 重启link-message.service
systemctl restart link-message.service
if [[ $? -eq 0  ]];then
  ok link-message.service 
else
  err link-message.service 
fi

#5 重启etcd
systemctl restart etcd 
if [[ $? -eq 0  ]];then
  ok etcd  
else
  err etcd
fi
#等待5s
ok sleep 5

#6 重启k8 api
systemctl restart kube-apiserver 
if [[ $? -eq 0  ]];then
  ok kube-apiserver
else
  err kube-apiserver
fi
#7 重启dcmsender
systemctl kill link-dicom-dcmsender
systemctl restart link-dicom-dcmsender.service
if [[ $? -eq 0  ]];then
  ok link-dicom-dcmsender.service
else
  err link-dicom-dcmsender.service
fi


#8 重启linkone
#kill linkone
KILL_LINONE=$(ps -ef | grep linkone | grep -v grep | awk '{print $2}' |wc -l)
if [[ ${KILL_LINONE} -eq 0 ]];then
  echo ""
else
  ps -ef | grep linkone | grep -v grep | awk '{print $2}' | xargs kill -9
fi
#启动
systemctl restart link-linkone.service
if [[ $? -eq 0  ]];then
  ok link-linkone.service 
else
  err link-linkone.service
fi

# 开机启动
systemctl enable link-ois2.service
systemctl enable link-dicom-api.service
systemctl enable link-dicom-archive.service
systemctl enable link-message.service
systemctl enable link-linkone.service
systemctl enable link-dicom-dcmsender.service 


##linkone
#ps -ef | grep linkingOIS2 | grep -v grep | awk '{print $2}' && ps -ef | grep linkone | grep -v grep | awk '{print $2}' | xargs kill -9
#cd /data/ois/site/backend/linkone
#systemctl restart etcd ;systemctl restart kube-apiserver ;nohup /usr/local/java/bin/java -jar linkone.jar >/dev/null 2>&1 &
#
##ois
#ps -ef | grep linkingOIS2 | grep -v grep | awk '{print $2}' && ps -ef | grep linkingOIS2 | grep -v grep | awk '{print $2}' | xargs kill -9
#
#cd /data/ois/site/backend/ois/linkingOIS2
#nohup /usr/local/java/bin/java -jar linkingOIS2.jar >/dev/null 2>&1 &
#
##api
#ps -ef | grep linkdicom-api-boot.jar | grep -v grep | awk '{print $2}' && ps -ef | grep linkdicom-api-boot.jar | grep -v grep | awk '{print $2}' | xargs kill -9
#
#cd /data/ois/site/backend/dicom/api
#nohup /usr/local/java/bin/java -jar   linkdicom-api-boot.jar --spring.profiles.active=local >/dev/null 2>&1 &
#
##archive
#ps -ef | grep linkdicom-archive-boot.jar | grep -v grep | awk '{print $2}' && ps -ef | grep linkdicom-archive-boot.jar | grep -v grep | awk '{print $2}' | xargs kill -9
#
#cd  /data/ois/site/backend/dicom/archive
#nohup /usr/local/java/bin/java -jar   linkdicom-archive-boot.jar --spring.profiles.active=local >/dev/null 2>&1 &
#
##message
#ps -ef | grep linkingmed-messageService.jar | grep -v grep | awk '{print $2}' && ps -ef | grep linkingmed-messageService.jar | grep -v grep | awk '{print $2}' | xargs kill -9
#
#cd /data/ois/site/backend/message
#nohup /usr/local/java/bin/java -jar linkingmed-messageService.jar --spring.profiles.active=local >/dev/null 2>&1 &
#
