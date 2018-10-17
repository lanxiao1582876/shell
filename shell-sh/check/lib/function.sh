function install_offlinerepo() {
  info "add offline.repo"
  mkdir /etc/yum.repos.d/bak/
  mv /etc/yum.repos.d/* /etc/yum.repos.d/bak/
  cp /data/base_ev/rpm-install/rpm/offline.repo /etc/yum.repos.d/
  yum clean all
  ok 'offline.repo 安装成功'
}
function install_jdk() {
  info "install java_env(jdk_8u131)"
  cp /data/base_ev/jdk-install/jdk_8u131_201805031200_lanxiao.tar.gz /usr/local
  cd /usr/local
  tar xvf jdk_8u131_201805031200_lanxiao.tar.gz
  mv jdk1.8.0_131 java
  rm -f /usr/local/jdk_8u131_201805031200_lanxiao.tar.gz
  echo -e '## JDK\nexport JAVA_HOME=/usr/local/java\nexport JRE_HOME=$JAVA_HOME/jre\nexport CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib\nexport PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin' >> /etc/profile
  source /etc/profile
  info $(java -version)
  ok  "jdk 安装成功"
}
function install_nginx() {
  info "install nginx-1.10.3"
  yum install nginx -y
  mv /etc/nginx/conf.d/default.conf{,.bak}
  info "copy conf file"
  cp -f /data/base_ev/nginx-install/raic.conf         /etc/nginx/conf.d/
  cp -f /data/base_ev/nginx-install/viewer-new.conf   /etc/nginx/conf.d/
  cp -f /data/base_ev/nginx-install/nginx.conf        /etc/nginx/
  ll /etc/nginx/conf.d/*.conf
  systemctl enable nginx
  systemctl restart nginx
  ok "nginx 安装成功"
}
 
function install_rabbitmq() {
  info "install rabbitmq"
  yum install rabbitmq-server -y
  rm -rf /var/lib/rabbitmq/.erlang.cookie
  cp  -f /data/base_ev/rabbitmq-install/rabbitmq.config /etc/rabbitmq/rabbitmq.config
  systemctl restart rabbitmq-server
  systemctl enable rabbitmq-server
  rabbitmq-plugins enable rabbitmq_management
  sh /data/shell-sh/check/module/init-rabbit.sh 
  ok  "rabbitmq  安装成功"
}

function install_mysql() {
  info "install mysql" 
  /bin/sh /data/base_ev/mysql-install/mysql-install.sh
  /bin/sh /data/init_db/mysql-data.sh
  ok "mysql 安装成功"
}

function install_docker() {
  info "install docker"
  yum   install  docker-ce -y
  DOCKER_CONF=/data/base_ev/docker-install/docker.service
  
  info "copy docker conf"
  mkdir -p /data/docker
  if [[ -f ${DOCKER_CONF} ]];then
      cp -f /data/base_ev/docker-install/docker.service  /usr/lib/systemd/system/docker.service
      systemctl daemon-reload
      systemctl restart docker
      systemctl enable docker
      docker --version
  else
      err "${DOCKER_CONF} is not exits"
  fi
  NVIDIA_DOCKER_CONF=/data/base_ev/docker-install/daemon.json

  info "install nvidia-docker2"
  yum install -y nvidia-docker2
  if [[ -f ${NVIDIA_DOCKER_CONF} ]];then
      cp -f /data/base_ev/docker-install/daemon.json /etc/docker/daemon.json
      systemctl daemon-reload
      systemctl restart docker
  else
      err "${NVIDIA_DOCKER_CONF} is not exits"
  fi

  info "load docker-images"
  IMAGES1=/data/docker-image/centos_python_segment.tar
  IMAGES2=/data/docker-image/k8s-device-plugin.tar
  IMAGES3=/data/docker-image/pod-infrastructure.tar
  
  if [[ -f ${IMAGES1} ]];then
      docker load -i ${IMAGES1}
      docker load -i ${IMAGES2}
      docker load -i ${IMAGES3}
      docker images
  else
      err "${IMAGES1} is not exits"
  fi

  ok "docker 安装成功"
}
function install_k8s() {
  #1 etcd 
  if [[ -d /data/k8s/kubernetes ]];then
      info "安装 etcd...................."
      yum install etcd -y
      cp /data/k8s/conf/etcd/etcd.conf  /etc/etcd/
      mkdir /data/etcd  -p
      chown etcd:etcd /data/etcd/ -R
      systemctl restart etcd
      
      #2 k8s server
      info "copy k8s conf................"
      mkdir -p /etc/kubernetes/
      mkdir -p /data/kubelet
      cp    /data/k8s/kubernetes/server/* /usr/bin
      cp -r /data/k8s/kubernetes/config/* /etc/kubernetes/
      cp    /data/k8s/kubernetes/system/* /lib/systemd/system/
      
      #3 conf
      info "修改 k8s conf................"
      #1) apiserver
      sed -i "s#KUBE_API_ADDRESS.*#KUBE_API_ADDRESS=\"--advertise-address=${1} --bind-address=${1} --insecure-bind-address=127.0.0.1\" #" /etc/kubernetes/kube-apiserver
      
      #2) kublet
      sed -i "s#NODE_ADDRESS.*#KUBE_API_ADDRESS=\"--advertise-address=${1} --bind-address=${1}\"#" /etc/kubernetes/kubelet
      sed -i "s#NODE_HOSTNAME.*#NODE_HOSTNAME=\"--hostname-override=${1}\"#" /etc/kubernetes/kubelet
      
      #3) proxy
      sed -i "s#NODE_HOSTNAME.*#NODE_HOSTNAME=\"--hostname-override=${1}\"#" /etc/kubernetes/proxy
      
      #5 enable
      info "start  enable   k8s"
      systemctl enable kube-apiserver.service
      systemctl enable kube-controller-manager.service
      systemctl enable kubelet
      systemctl enable kube-proxy
      systemctl enable kube-scheduler
      
      #6 start 
      systemctl restart kube-apiserver.service
      systemctl restart kube-controller-manager.service
      systemctl restart kubelet
      systemctl restart kube-proxy
      systemctl restart kube-scheduler
      
      #7 GPU
      sleep 5
      info  "install plugin  namespace.............."
      kubectl create -f /data/k8s/nvidia-device-plugin.yml
      
      #8 namespace
      kubectl create namespace linkingmed
      kubectl label node $1 env=local pref=high-priority processor=gpu
      ok "k8s 安装成功"
    else 
      err "/data/k8s/kubernetes 不存在" 
      exit 0  
fi
}

function install_nfs() {
  #1 install nfs
  yum install nfs-utils -y
  #2 conf
  info "copy nfs conf"
  NFS_CONF=/data/base_ev/nfs-install/exports
  if [[ -f ${NFS_CONF} ]];then
      cp -f  ${NFS_CONF} /etc/exports
  else
      err "${NFS_CONF} is not exists"
  fi
  #3 start 
  info "start nfs"
  systemctl restart nfs
  systemctl enable nfs
  #4 dir
  info "mount nfs"
  mkdir /data/alg/run -p
  mkdir /alg/data -p
  #5 mount 
  mount ${1}:/data/alg/run/ /alg/data/
  #6 fstab
  info "nfs fstab"
  if [ $(grep nfs /etc/fstab|wc -l ) -eq 0 ];then
    sed -i "\$a ${1}:/data/alg/run  /alg/data            nfs     defaults        0 0" /etc/fstab
  else
    echo "nfs is already in /etc/fstab"
  fi
  df -Th
  ok "nfs 安装成功"
}
