#!/bin/bash

docker run \
  --network=ambari-network \
  --ip=192.168.100.104 \
  --name=ambari-h4 \
  -h=ambari-h4.chenliujin.com \
  -d \
  --restart=always \
  chenliujin/ambari-agent:2.6.2 /usr/sbin/init
