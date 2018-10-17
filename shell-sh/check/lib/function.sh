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
  /bin/sh /data/base_ev/docker-install/docker-install.sh
  /bin/sh /data/base_ev/docker-install/docker-load-image.sh
  ok "docker 安装成功"
}
function install_k8s() {
  info "install k8s"
  /bin/sh /data/k8s/k8s-install.sh
  ok "k8s 安装成功"
}
function install_nfs() {
  info "install nfs"
  /bin/sh /data/base_ev/nfs-install/nfs-install.sh
  ok "nfs 安装成功"
}

