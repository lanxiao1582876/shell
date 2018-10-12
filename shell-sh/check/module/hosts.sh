#!/bin/bash
#1
info 'hosts'
if [ $( grep OIS-GPU /etc/hosts|wc -l) -eq 2 ];then
   ok "hosts"
   cgrep OIS-GPU /etc/hosts   
else
   err "hosts 文件没有写主机名"
   sed -i '1s/$/ OIS-GPU/' /etc/hosts
fi

#2
info 'file limit'
if [ $(grep 65536 /etc/security/limits.conf|wc -l) -eq 2 ];then
   ok 'file limit'
   cgrep 65536 /etc/security/limits.conf
else
   err ' limit 没有修改限制数'
   sed -i '$i * hard  nofile   65536' /etc/security/limits.conf
   sed -i '$i * soft  nofile   65536' /etc/security/limits.conf
fi

#3
info 'swap'
if [ $(free -h | grep Swap |awk '{print $2}') = '0B' ];then
   ok 'swap'
else
   err 'swap 没有关闭'
   swapoff -a
fi

#4
info 'ip_forward'
if  [ $(cat /proc/sys/net/ipv4/ip_forward) = '1' ];then
   ok 'ip_forward'
else
   err 'ip转发没有开启'
   echo 1 >/proc/sys/net/ipv4/ip_forward
fi

