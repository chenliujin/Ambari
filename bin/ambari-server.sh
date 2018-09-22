#!/bin/bash

docker run \
  -d \
  --restart=always \
  --name=ambari-server \
  --network=ambari-network \
  --ip=192.168.100.99 \
  -h=ambari-server.chenliujin.com \
  h1:latest /usr/sbin/init
