#!/bin/sh
#0 source 函数(all)
source /data/shell-sh/check/lib/function.sh
#1 source 自己的lib文件(all)
source /data/shell-sh/check/lib/basic.sh
source /data/update/base.sh

#2 升级sql
source /data/update/model/update_sql_CPU.sh
#3 升级工程包
source /data/update/model/ois.sh
#4 shell-sh
source /data/update/model/shell.sh
#tmp
cp /data/shell-sh/system/link-jasperserver.service /lib/systemd/system
#5 升级nginx
source /data/update/model/nginx.sh
#6 升级base_ev
source /data/update/model/base_ev.sh
#7 安装字体
source /data/update/model/fonts.sh

