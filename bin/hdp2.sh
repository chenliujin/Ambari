#!/bin/bash

docker run \
  --network=ambari-network \
  --ip=192.168.100.102 \
  --name=hdp2 \
  -h=hdp2.chenliujin.com \
  -d \
  --restart=always \
  chenliujin/ambari-agent:2.6.2 /usr/sbin/init
