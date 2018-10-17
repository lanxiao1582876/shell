#1
info "install docker"
if [[ $(rpm -qa docker-ce|wc -l) -eq 1 ]];then
  ok 'docker 已经安装'
else
  err 'docker 没有安装'
  install_docker
fi

#2 
info  "install k8s"
if [[ $(ll /lib/systemd/system/kube*|wc -l) -eq 5 ]];then
  ok 'k8s 已经安装'
else
  err 'k8s 没有安装'
  install_docker
fi

#3
info "install nfs"
if [[ $(rpm -qa nfs-utils|wc -l) -eq 1 ]];then
  ok "nfs 已经安装"
else
  err "nfs 没有安装"
  install_nfs
fi

