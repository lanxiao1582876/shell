#!/usr/bin/env bash
# Init rabbitMQ

ok()   { echo -e "\033[42;37m[  OK ]\033[0m $(date +"[%F %T]") $@";}
err()  { echo -e "\033[41;37m[ERROR]\033[0m $(date +"[%F %T]") $@" >&2;}
info() { echo -e "\033[33m---------------$@--------------- \033[0m";}

RABBITADMIN=/data/shell-sh/check/utils/rabbitmqadmin 
RABBIT_RUNNING=$(ss -antpl|grep :5672|wc -l)
RABBIT_PROCESS=$(ps -aux|grep -v grep|grep rabbitmq_server|wc -l)

function rabbit_check() {
  if [ ${RABBIT_RUNNING} -eq 1  -a  ${RABBIT_PROCESS} -eq 1 ];then
    return 3
  else
    return 4
  fi
}

function init() {
  ${RABBITADMIN} declare user name=lm-mq-user password=lm-mq-user008 tags=administrator >/dev/null
  ${RABBITADMIN} declare exchange name=lm.task.exchange type=fanout >/dev/null
  ${RABBITADMIN} declare exchange name=lm.notification.exchange type=fanout >/dev/null
  ${RABBITADMIN} declare queue name=lm.dicom.task.status.queue >/dev/null
  ${RABBITADMIN} declare queue name=lm.linkmatrix.task.status.queue >/dev/null
  ${RABBITADMIN} declare queue name=lm.notification.queue >/dev/null
  ${RABBITADMIN} declare binding source=lm.task.exchange destination=lm.dicom.task.status.queue routing_key=lm.task.status.dicom.key >/dev/null
  ${RABBITADMIN} declare binding source=lm.task.exchange destination=lm.linkmatrix.task.status.queue routing_key=lm.task.status.linkmatrix.key >/dev/null
  ${RABBITADMIN} declare binding source=lm.notification.exchange destination=lm.notification.queue routing_key=lm.notification.key >/dev/null
  ${RABBITADMIN} declare permission vhost=/ user=lm-mq-user configure=.* write=.* read=.* >/dev/null
  ${RABBITADMIN} declare queue name="lm.archive.queue" durable=true
  ${RABBITADMIN} declare queue name="lm.archive.status.linkmatrix.queue" durable=true
  ${RABBITADMIN} declare queue name="lm.archive.status.teamedicine.queue" durable=true
  ${RABBITADMIN} declare exchange name="lm.archive.exchange" type=topic
  ${RABBITADMIN} declare binding source="lm.archive.exchange" destination_type="queue" destination="lm.archive.queue" routing_key="lm.archive.key"
  ${RABBITADMIN} declare binding source="lm.archive.exchange" destination_type="queue" destination="lm.archive.status.linkmatrix.queue" routing_key="lm.archive.status.linkmatrix.key"
  ${RABBITADMIN} declare binding source="lm.archive.exchange" destination_type="queue" destination="lm.archive.status.teamedicine.queue" routing_key="lm.archive.status.teamedicine.key"
  
  ${RABBITADMIN} declare queue name="lm.dicom.dcm.send.queue" durable=true
  ${RABBITADMIN} declare exchange name="lm.dicom.dcm.send.exchange" type=topic
  ${RABBITADMIN} declare binding source="lm.dicom.dcm.send.exchange" destination_type="queue" destination="lm.dicom.dcm.send.queue" routing_key="lm.dicom.dcm.send.key"
  ${RABBITADMIN} declare queue name="lm.archive.status.ois.queue" durable=true
  ${RABBITADMIN} declare binding source="lm.archive.exchange" destination_type="queue" destination="lm.archive.status.ois.queue" routing_key="lm.archive.status.ois.key"
  ${RABBITADMIN} list users
  ${RABBITADMIN} list permissions
  ${RABBITADMIN} list exchanges
  ${RABBITADMIN} list queues
  ${RABBITADMIN} list bindings
}

rabbit_check

if [ $? -eq 3 ];then
  ok "RabbitMQ is running"
  init
else
  err "RabbitMQ is NOT running"
  systemctl restart rabbitmq-server
  init
fi
