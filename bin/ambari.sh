#!/bin/bash

docker run \
  -d \
  --restart=always \
  --name=ambari \
  --network=ambari-network \
  --ip=192.168.100.99 \
  --privileged \
  -h=ambari.chenliujin.com \
  chenliujin/ambari-server:2.6.2 /usr/sbin/init
