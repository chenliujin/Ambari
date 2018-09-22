#!/bin/bash

docker run \
  -d \
  --name=ambari-mysql \
  --restart=always \
  --network=ambari-network \
  --ip=192.168.100.100 \
  -p 3307:3306 \
  -e MYSQL_ROOT_PASSWORD='chenliujin' \
  mysql:5.7.18
