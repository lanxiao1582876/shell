#!/bin/sh
#author  lan.xiao@linkingmed.com
#date    2018-05-03 12:00

#1 Disable SELINUX
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0

#2 Delete mariadb
rpm -qa | grep mariadb
[ $? -eq 0 ] && rpm -qa | grep mariadb | xargs rpm --nodeps -e

#3  Install MySQL5.7
yum install mysql-server -y
#4 Configure
mkdir -p  /data/mysql
chown -R  mysql.mysql /data/mysql
sed -i 's@datadir=/var/lib/mysql@datadir=/data/mysql@g' /etc/my.cnf
sed -i '/^\[mysqld\]$/a\character_set_server=utf8' /etc/my.cnf
sed -i '/^\[mysqld\]$/a\sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' /etc/my.cnf

#5 start
systemctl start  mysqld.service
systemctl enable mysqld.service

#6 修改密码
PASS=$(grep 'temporary password' /var/log/mysqld.log | tail -1 |awk '{print $NF}')
/usr/bin/mysql -uroot -p${PASS} --connect-expired-password <<EOF
set global validate_password_policy = 0;
SET PASSWORD = PASSWORD('Linkingmed2018@');
grant all privileges on *.* to root@'%' identified by 'Linkingmed2018@';
EOF

