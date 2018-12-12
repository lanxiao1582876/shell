#!/bin/bash
mysql -uroot -pLinkingmed2018@ -e "drop database linkingois"
mysql -uroot -pLinkingmed2018@ -e "create database linkingois"
mysql -uroot -pLinkingmed2018@ -e "drop database linkone"
mysql -uroot -pLinkingmed2018@ -e "create database linkone"
mysql -uroot -pLinkingmed2018@ -e "drop database message"
mysql -uroot -pLinkingmed2018@ -e "create database message"
mysql -uroot -pLinkingmed2018@ -e "drop database linkdicom"
mysql -uroot -pLinkingmed2018@ -e "create database linkdicom"

mysql -uroot -pLinkingmed2018@ linkingois < /data/init_db/ois/ois.sql
mysql -uroot -pLinkingmed2018@ linkdicom <  /data/init_db/dicom/dicom.sql
mysql -uroot -pLinkingmed2018@ linkone <    /data/init_db/linkone/linkone.sql 
mysql -uroot -pLinkingmed2018@ message <   /data/init_db/message/message.sql 
