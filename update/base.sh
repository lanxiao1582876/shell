#!/bin/bash
LINKONE_BAK=/data/bak/linkone
LINKONE_ZIP=/data/update/linkone.zip
LINKONE_DIR=/data/ois/site/backend/linkone

DATE=$(date +"%Y%m%d%H%M%S")
OIS_BAK=/data/bak/ois
OIS_ZIP=/data/update/ois.zip

SQL_BAK=/data/bak/mysql_bak
OIS_SQL_DIR=/data/update/sql/ois/ois.sql 
DICOM_SQL_DIR=/data/update/sql/ois/ois.sql 
MYSQLDUMP=$(mysqldump -uroot -p'Linkingmed2018@')

ALG_BAK=/data/bak/alg
ALG_DIR=/data/alg/prog
ALG_ZIP=/data/update/gouba.alg.zip

SHELL_BAK=/data/bak/shell-sh/
SHELL_DIR=/data/shell-sh
SHELL_ZIP=/data/update/shell-sh.zip

IMAGE_ZIP=/data/update/alg.image.zip

NGINX_BAK=/data/bak/nginx
NGINX_DIR=/etc/nginx/conf.d/
NGINX_CONF_RAIK=/data/update/raic.conf
NGINX_CONF_VIEWER=/data/update/viewer-new.conf

