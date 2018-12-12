#!/bin/bash
# jasperserver
JASPEXR_CONF=/data/ois/site/backend/jasperserver/jasperserver/META-INF/context.xml
JASPEXR_CONF_A=/data/ois/site/backend/jasperserver/config/application-local.properties
if [ -f ${JASPEXR_CONF} ];then
  #1)mysql
  sed -i 's#url="jdbc:mysql://.*/jasperserver#url="jdbc:mysql://127.0.0.1:3306/jasperserver#g' ${JASPEXR_CONF}
  sed -i 's#username=.*#username="root" password="Linkingmed2018@"#g'  ${JASPEXR_CONF} 
  sed -i 's///' ${JASPEXR_CONF}
  ok "JASPEXR_CONF"
  sed -i "s#server.host=.*#server.host=${1}#g"  ${JASPEXR_CONF_A}
else
  err "${JASPEXR_CONF} is not exist"
fi
