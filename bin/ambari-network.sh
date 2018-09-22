#!/bin/bash

docker network create \
  --driver bridge \
  --subnet 192.168.100.0/24 \
  --gateway 192.168.100.1 \
  -o parent=eth0 \
  ambari-network
