#!/bin/bash

docker run \
  --network=ambari-network \
  --ip=192.168.100.103 \
  --name=ambari-h33 \
  -h=ambari-h3.chenliujin.com \
  -d \
  --restart=always \
  chenliujin/ambari-agent:2.6.2 /usr/sbin/init
