#!/bin/bash

docker run \
  --network=ambari-network \
  --ip=192.168.100.102 \
  --name=ambari-h2 \
  -h=ambari-h2.chenliujin.com \
  -d \
  --restart=always \
  chenliujin/ambari-agent:2.6.2 /usr/sbin/init
