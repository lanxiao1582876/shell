#!/bin/sh
#0 source 函数
source /data/shell-sh/check/lib/function.sh
#1 source 自己的lib文件
source /data/shell-sh/check/lib/basic.sh
#2 检查磁盘
source /data/shell-sh/check/module/disk.sh
#3 检查防火墙
source /data/shell-sh/check/module/firewalld.sh
#4 检查hosts
source /data/shell-sh/check/module/hosts.sh
#5 检查离线环境的rpm包及repo文件
source /data/shell-sh/check/module/rpm-repo.sh
#6 检查显卡驱动
source /data/shell-sh/check/module/nvidia-install.sh
#7 检查各种软件包是否安装
source /data/shell-sh/check/module/yum-install-CPU.sh
sleep 2
#source module/install_gpu.sh
source /data/shell-sh/check/module/install_gpu.sh 

#8 安装ois工程包
sleep 2
source /data/shell-sh/check/module/ois-install.sh
#9 安装gouba alg
source /data/shell-sh/check/module/gouba-alg-install.sh
#10 修改ip
source /data/shell-sh/ip_change.sh
#11 启动ois
source /data/shell-sh/ois_start.sh
#12 定时任务
crontab /data/shell-sh/cron/crontest.cron





