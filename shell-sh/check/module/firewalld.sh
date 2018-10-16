#!/bin/bash
#1 firewalld
info "firewalld"
if [ $(systemctl status firewalld | grep "Active: inactive" |wc -l) -eq 1  ];then
  ok "firewalld"
  systemctl disable firewalld
else
  err "firewalld"
  systemctl stop firewalld
  systemctl disable firewalld
  ok "firewalld OK"
fi

#2 selinux
info  "selinux"
if [ $(getenforce) = "Disabled" ];then
  ok "selinux disabled"
else
  err "selinux"
  setenforce 0
  sed -i 's#^SE.*#SELINUX=disabled#' /etc/selinux/config
  ok "selinux OK"
fi

#3 # 优化视觉
info "优化视觉"
if [ $(grep "PS1=" /root/.bash_profile|wc -l) -eq 1 ];then
  ok "优化视觉"
else
  err "优化视觉"
  echo "PS1='\[\e[31;1m\]\u\[\e[33;1m\]@\[\e[32;1m\]\h:\[\e[36;1m\]\w\[\e[35;1m\]\$>\[\e[0m\]'" >>/root/.bash_profile
  echo alias ll=\'ls -alh --time-style=+\"[%Y-%m-%d %H:%M]\"\' >>/root/.bash_profile
  echo "alias cd..='cd ..'
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias vi='vim'
  " >>/root/.bash_profile
  sleep 1
  source /root/.bash_profile
  ok "优化视觉 OK"
fi
