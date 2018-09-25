#!/bin/bash

docker run \
  --network=ambari-network \
  --ip=192.168.100.103 \
  --name=hdp3 \
  -h=hdp3.chenliujin.com \
  --privileged \
  -d \
  --restart=always \
  chenliujin/ambari-agent:2.6.2 /usr/sbin/init
