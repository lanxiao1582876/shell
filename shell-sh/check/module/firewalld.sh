#!/bin/bash

info "firewalld"
if [ $(systemctl status firewalld | grep "Active: inactive" |wc -l) -eq 1  ];then
  ok "firewalld"
  systemctl disable firewalld
else
  err "firewalld"
  systemctl stop firewalld
  systemctl disable firewalld
fi

info  "selinux"
if [ $(getenforce) = "Disabled" ];then
  ok "selinux disabled"
else
  err "selinux"
  setenforce 0
  sed -i 's#^SE.*#SELINUX=disabled#' /etc/selinux/config
fi


