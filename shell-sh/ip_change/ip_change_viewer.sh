#!/bin/bash
# viewer
source /data/shell-sh/check/lib/basic.sh
VIEWER_CONF=/data/ois/site/frontend/viewer/index.html
if [ -f ${VIEWER_CONF} ];then
  sed -i "s#\s   window.backendDomain.*#    window.backendDomain = 'http://'+document.domain+':9091/'#" ${VIEWER_CONF}
  sed -i "s#\s   window.wsDomain.*#    window.wsDomain = 'ws://'+document.domain+':9091/'#" ${VIEWER_CONF}
  ok "VIEWER_CONF"
else
  err "${VIEWER_CONF} is not exist"
fi
# viewer-new
VIEWER_NEW_CONF=/data/ois/site/frontend/viewer-new/index.html
if [ -f ${VIEWER_NEW_CONF} ];then
  sed -i "s#// window.serverUrl = .*#window.serverUrl = 'http://'+document.domain+':9093'#" ${VIEWER_NEW_CONF}
  sed -i "s#// window.ws = '.*/message-service/message'#window.ws = 'ws://'+document.domain+':9093/message-service/message'#" ${VIEWER_NEW_CONF}
  ok  "VIEWER_NEW_CONF"
else
  err  "${VIEWER_NEW_CONF} is not exist"
fi

