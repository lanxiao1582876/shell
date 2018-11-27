#!/bin/bash
info '显卡驱动'
if [ $(rpm -qa kmod-nvidia | wc -l) -eq 0 ];then
  cd /data/base_ev/nvidia-install/ &&  /bin/sh nvidia.sh
  echo "显卡驱动已安装成功，请重启服务器后再次执行该脚本"
  exit 0
else
  ok "显卡已经安装"
fi

