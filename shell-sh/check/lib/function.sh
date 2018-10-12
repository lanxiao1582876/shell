function install_k8srepo() {
  mkdir /etc/yum.repos.d/bak/
  mv /etc/yum.repos.d/* /etc/yum.repos.d/bak/
  cp /data/base_ev/rpm-install/rpm/k8s.repo /etc/yum.repos.d/
  yum clean all
  ok 'k8s.repo 安装成功'
}
function install_jdk() {
  cp /data/base_ev/jdk-install/jdk_8u131_201805031200_lanxiao.tar.gz /usr/local
  cd /usr/local
  tar xvf jdk_8u131_201805031200_lanxiao.tar.gz
  mv jdk1.8.0_131 java
  rm -f /usr/local/jdk_8u131_201805031200_lanxiao.tar.gz
  echo -e '## JDK\nexport JAVA_HOME=/usr/local/java\nexport JRE_HOME=$JAVA_HOME/jre\nexport CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib\nexport PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin' >> /etc/profile
  source /etc/profile
  java -version
  ok  "jdk 安装成功"
}
function install_nginx() {
  yum install nginx -y
  mv /etc/nginx/conf.d/default.conf{,.bak}
  cp -f /data/base_ev/nginx-install/raic.conf         /etc/nginx/conf.d/
  cp -f /data/base_ev/nginx-install/viewer-new.conf   /etc/nginx/conf.d/
  cp -f /data/base_ev/nginx-install/nginx.conf        /etc/nginx/
  systemctl enable nginx
  systemctl restart nginx
  ok 'nginx 安装成功'
}
function install_rabbitmq() {
  yum install rabbitmq-server -y
  rm -rf /var/lib/rabbitmq/.erlang.cookie
  systemctl restart rabbitmq-server
  systemctl enable rabbitmq-server
  rabbitmq-plugins enable rabbitmq_management
  cp  -f /data/base_ev/rabbitmq-install/rabbitmq.config /etc/rabbitmq/rabbitmq.config
  systemctl restart rabbitmq-server
  ok  'rabbitmq  安装成功'
}

