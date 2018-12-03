#!/bin/sh
#0 source 函数(all)
source /data/shell-sh/check/lib/function.sh
#1 source 自己的lib文件(all)
source /data/shell-sh/check/lib/basic.sh
source /data/update/base.sh
#2 升级sql
source /data/update/model/update_sql_GPU.sh
#3 升级工程包
source /data/update/model/linkone.sh
#4 shell-sh
source /data/update/model/shell.sh
#5 升级算法
source /data/update/model/alg.sh

