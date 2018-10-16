#!/bin/bash
#1
info 'hosts'
if [ $( grep OIS-GPU /etc/hosts|wc -l) -eq 2 ];then
   ok "hosts"
   grep OIS-GPU /etc/hosts   
else
   err "hosts 文件没有写主机名"
   sed -i '1s/$/ OIS-GPU/' /etc/hosts
   ok "hosts OK"
fi

#2
info 'file limit'
if [ $(grep 65536 /etc/security/limits.conf|wc -l) -eq 2 ];then
   ok 'file limit'
else
   err ' limit 没有修改限制数'
   sed -i '$i * hard  nofile   65536' /etc/security/limits.conf
   sed -i '$i * soft  nofile   65536' /etc/security/limits.conf
   ok 'limit OK'
fi

#3
info 'swap'
if [ $(free -h | grep Swap |awk '{print $2}') = '0B' ];then
   ok 'swap'
else
   err 'swap 没有关闭'
   swapoff -a
   ok 'swap OK'
fi
FSTAB=/etc/fstab
info "swap  fstab file"
if [ $(grep ${SWAP} ${FSTAB}|wc -l) -eq 1  ];then
  ok $(grep ${SWAP} /etc/fstab)
else
  err "swap fstab ERROR!!!"
  sed -i 's$/dev/mapper/cl-swap$#/dev/mapper/cl-swap/$' /etc/fstab
  ok  "swap fstab OK"
fi


#4
info 'ip_forward'
if  [ $(cat /proc/sys/net/ipv4/ip_forward) = '1' ];then
   ok 'ip_forward'
   echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
   sysctl -p /etc/sysctl.conf

else
   err 'ip转发没有开启'
   echo 1 >/proc/sys/net/ipv4/ip_forward
   echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
   sysctl -p /etc/sysctl.conf
   ok "ip_forward OK"
fi

