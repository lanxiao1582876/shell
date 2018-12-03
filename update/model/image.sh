#!/bin/bash
if [[ -f ${IMAGE_ZIP} ]];then
    info "更新镜像"
    unzip ${IMAGE_ZIP} -d /data/update
    docker load -i /data/update/centos_python_segment.tar
    ok "镜像更新成功"
else
    info "镜像不更新"
fi 
