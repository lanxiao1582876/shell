#!/bin/bash
#没有model的算法替换
DATE=$(date +"%Y%m%d%H%M%S")
MODEL_DIR=/data/alg/prog/model/
ALG_BAK=/data/bak/alg
ALG_DIR=/data/alg/prog
ALG_ZIP=/data/update/gouba.alg.zip
mkdir -p ${ALG_BAK}
#1 bak
mv ${MODEL_DIR}  /data/alg/
mv ${ALG_DIR}  ${ALG_BAK}/prog.bak_${DATE}
echo "alg备份成功  备份目录在${ALG_BAK}"
#2 unzip 
cd /data
cp ${ALG_ZIP} .
unzip -q gouba.alg.zip
mv /data/alg/model/ ${ALG_DIR}
echo "alg 更新成功"

