#!/bin/sh
#0 source 函数
source lib/function.sh
#1 source 自己的lib文件
source lib/basic.sh
#2 检查磁盘
source module/disk.sh
#3 检查防火墙
source module/firewalld.sh
#4 检查hosts
#source module/hosts.sh
##5 检查离线环境的rpm包及repo文件
#source module/rpm-repo.sh
##6 检查显卡驱动
#source module/nvidia-install.sh
##7 检查各种软件包是否安装
#source module/yum-install.sh
##8 检查rabbitmq配置
#source module/init-rabbit.sh

