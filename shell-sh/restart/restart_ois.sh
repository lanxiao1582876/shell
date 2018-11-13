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

#5 重启dcmsender
KILL_SENDER=$(ps -ef | grep dcmsender | grep -v grep | awk '{print $2}' |wc -l)
if [[ ${KILL_SENDER} -eq 0 ]];then
  echo ""
else
  ps -ef | grep dcmsender | grep -v grep | awk '{print $2}' | xargs kill -9
fi
systemctl restart link-dicom-dcmsender.service
if [[ $? -eq 0  ]];then
  ok link-dicom-dcmsender.service
else
  err link-dicom-dcmsender.service
fi

# 开机启动
systemctl enable link-ois2.service
systemctl enable link-dicom-api.service
systemctl enable link-dicom-archive.service
systemctl enable link-message.service
systemctl enable link-dicom-dcmsender.service 

