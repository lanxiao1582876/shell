#!/usr/bin/env bash
ETHIP=$(ip a|grep -E "^[0-9]*: en" -A 2|grep inet|awk '{print $2}'|awk -F "/" '{print $1}')

echo ........................Local IP: ${ETHIP}...............................
ok()   { echo -e "\033[42;37m[  OK ]\033[0m $(date +"[%F %T]") $@";}
err()  { echo -e "\033[41;37m[ERROR]\033[0m $(date +"[%F %T]") $@" >&2; }
info() { echo -e "\033[33m---------------$@--------------- \033[0m";}
cgrep() { grep --color=auto $@; }
