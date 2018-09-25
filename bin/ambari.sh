#!/bin/bash

docker run \
  -d \
  --restart=always \
  --name=ambari \
  --network=ambari-network \
  --ip=192.168.100.99 \
  -h=ambari.chenliujin.com \
  h1:latest /usr/sbin/init
