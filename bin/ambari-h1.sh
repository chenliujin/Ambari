#!/bin/bash

docker run \
  --network=ambari-network \
  --ip=192.168.100.101 \
  --name=ambari-h1 \
  -h=ambari-h1.chenliujin.com \
  -d \
  --restart=always \
  chenliujin/ambari-agent:2.6.2 /usr/sbin/init
