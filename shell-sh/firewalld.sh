#!/bin/bash
# 关闭防火墙
systemctl stop firewalld
systemctl disable firewalld
setenforce 0
sed -i 's#^SE.*#SELINUX=disabled#' /etc/selinux/config
getenforce

# 优化视觉
echo "PS1='\[\e[31;1m\]\u\[\e[33;1m\]@\[\e[32;1m\]\h:\[\e[36;1m\]\w\[\e[35;1m\]\$>\[\e[0m\]'" >>/etc/bashrc
echo alias ll=\'ls -alh --time-style=+\"[%Y-%m-%d %H:%M]\"\' >>/etc/bashrc

echo "alias cd..='cd ..'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vi='vim'
" >>/etc/bashrc

sleep 1
source /etc/bashrc
