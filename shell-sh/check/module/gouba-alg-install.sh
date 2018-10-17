#!/bin/bash
info "install gouba alg"
if [[ -d /data/alg/prog ]];then
    ok "gouba alg 已经安装"
else
    err "gouba alg 没有安装"
    cd /data
    if [[ -f gouba.alg.zip ]];then
        unzip  gouba.alg.zip
    else
        err "gouba.alg.zip is not exists"
    fi
fi  
