#!/bin/bash

docker run \
  -d \
  --name=ambari-mysql \
  --restart=always \
  --network=ambari-network \
  --ip=192.168.100.100 \
  -p 3307:3306 \
  -e MYSQL_ROOT_PASSWORD='chenliujin' \
  chenliujin/ambari-mysql:2.6.2
  #mysql:5.7.18
  #chenliujin/ambari-mysql:2.6.2 /bin/bash /usr/local/bin/docker-entrypoint.sh
