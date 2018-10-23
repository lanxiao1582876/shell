#!/bin/bash
#0 source 函数(all)
source /data/shell-sh/check/lib/function.sh
#1 source 自己的lib文件(all)
source /data/shell-sh/check/lib/basic.sh
#2 检查磁盘(all)
source /data/shell-sh/check/module/disk.sh
#3 检查防火墙(all)
source /data/shell-sh/check/module/firewalld.sh
#4 检查离线环境的rpm包及repo文件(all)
source /data/shell-sh/check/module/rpm-repo.sh

echo "请选择单机安装还是双机安装：
    1)单机安装
    2)双机安装
    3)退出
"
while :;do
read -p "#?" CHOOSE
case ${CHOOSE} in
    1)
    #5 检查hosts(GPU)
    source /data/shell-sh/check/module/hosts.sh
    #6 检查显卡驱动(GPU)
    source /data/shell-sh/check/module/nvidia-install.sh
    #7 检查各种软件包是否安装
    #(all)
    source /data/shell-sh/check/module/yum-install-all.sh
    #(CPU)
    source /data/shell-sh/check/module/yum-install-CPU.sh
    #(GPU)
    source /data/shell-sh/check/module/yum-install-GPU.sh
    #8 安装ois工程包
    sleep 2
    #(CPU)
    source /data/shell-sh/check/module/ois-install.sh
    #(GPU)
    source /data/shell-sh/check/module/linkone-install.sh
    #9 安装gouba alg(GPU)
    source /data/shell-sh/check/module/gouba-alg-install.sh
    #10 修改ip(all)
    source /data/shell-sh/ip_change.sh
    #11 启动ois(all)
    source /data/shell-sh/ois_start.sh
    #12 定时任务(all)
    crontab /data/shell-sh/cron/crontest.cron  
    exit
    ;;
    2) echo "请选择本机服务器类型(请仔细)：
           1)CPU机器
           2)GPU机器
           3)返回上一界面
       "
       while :;do
       read -p "#?" CHOOSEA
       case ${CHOOSEA} in 
           1)  #1 检查各种软件包是否安装
               #(all)
               source /data/shell-sh/check/module/yum-install-all.sh
               #(CPU)
               source /data/shell-sh/check/module/yum-install-CPU.sh 
               #2 安装ois工程包
               source /data/shell-sh/check/module/ois-install.sh
               #3 修改ip(all)
               source /data/shell-sh/ip_change.sh
               #4 启动ois(all)
               source /data/shell-sh/ois_start.sh
               #5 定时任务(all)
               crontab /data/shell-sh/cron/crontest.cron 
               exit
           ;;
           2)
               #1 检查hosts(GPU)
               source /data/shell-sh/check/module/hosts.sh
               #2 检查显卡驱动(GPU)
               source /data/shell-sh/check/module/nvidia-install.sh
               #3 检查各种软件包是否安装
               #(all)
               source /data/shell-sh/check/module/yum-install-all.sh
               #(GPU)
               source /data/shell-sh/check/module/yum-install-GPU.sh
               #4 安装ois工程包
               #(GPU)
               source /data/shell-sh/check/module/linkone-install.sh
               #5 安装gouba alg(GPU)
               source /data/shell-sh/check/module/gouba-alg-install.sh
               #6 修改ip(all)
               source /data/shell-sh/ip_change.sh
               #7 启动ois(all)
               source /data/shell-sh/ois_start.sh
               #8 定时任务(all)
               crontab /data/shell-sh/cron/crontest.cron
               exit
           ;;
           3) break        ;; 
       esac
       done ;;
    3) exit  ;;
esac
done
