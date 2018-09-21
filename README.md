

# Docker Install

## docker image
- dns
- ambari-server
  - ambari-server
  - ntp
- ambari-agent
  - ambari-agent
  - ntp

- 192.168.100.2   dns.chenliujin.com
- 192.168.100.100 ambari-mysql.chenliujin.com
- 192.168.100.101 ambari-server.chenliujin.com 
- 192.168.100.102 ambari-h2.chenliujin.com 
- 192.168.100.103 ambar-h3.chenliujin.com

## 1. DNS Service

### 1.1 Docker Container

```
docker run \
  --name=dns \
  --network=ambari-network \
  --ip=192.168.100.2 \
  -h=dns.chenliujin.com \
  -d \
  --restart=always \
  centos:1.0.0 /usr/sbin/init
```

### 1.2 安装 DNS Service

```
ansible-playbook dns.yml
```

### 1.3 修改宿主服务器 DNS

```
# vim /etc/resolv.conf
nameserver 192.168.100.2
nameserver 114.114.114.114
nameserver 8.8.8.8

# chattr +i /etc/resolv.conf --read only
```

## 2. Docker network

```
docker network create \
  --driver bridge \
  --subnet 192.168.100.0/24 \
  --gateway 192.168.100.1 \
  -o parent=eth0 \
  ambari-network
```

## 3. Ambari MySQL

### 3.1 docker mysql

```
docker run \
  -d \
  --name=ambari-mysql \
  --restart=always \
  --network=ambari-network \
  --ip=192.168.100.100 \
  -p 3307:3306 \
  -e MYSQL_ROOT_PASSWORD='chenliujin' \
  mysql:5.7.18
```

### 3.2 mysql init

- /var/lib/ambari-server/resources/Ambari-DDL-MySQL-CREATE.sql

```
# mysql -h 192.168.100.100 -uroot -p
mysql > create database ambari;
mysql > CREATE USER 'ambari'@'%' IDENTIFIED BY 'chenliujin';
mysql > GRANT ALL PRIVILEGES on ambari.* to ambari@'%';
mysql > flush privileges;
mysql > use ambari;
mysql > source /root/Ambari-DDL-MySQL-CREATE.sql;
```
## 4 ambari-server

- 192.168.100.101 ambari-server.chenliujin.com
  - dns
  - ambari-server
  - ntp

### 4.1 Docker

```
docker run \
  -d \
  --restart=always \
  --name=ambari-server \
  --network=ambari-network \
  --ip=192.168.100.101 \
  -h=ambari-server.chenliujin.com \
  h1:latest /usr/sbin/init
```

### 4.2 yum 

#### 4.2.1

```
curl http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.2.0/ambari.repo -o /etc/yum.repos.d/ambari.repo
```

#### 4.2.2

```
# yum install -y ambari-server
```

#### 4.2.3 MySQL Connector

```
yum install -y mysql-connector-java

ln -s /usr/share/java/mysql-connector-java.jar /var/lib/ambari-server/resources/mysql-connector-java.jar
```






## 2. Hive

```
mysql > create database hive;
mysql > CREATE USER 'hive'@'%' IDENTIFIED BY 'chenliujin';
mysql > GRANT ALL PRIVILEGES on hive.* to hive@'%';
mysql > flush privileges;
```

# 初始化

```
# ambari-server setup --api-ssl=false

Using python  /usr/bin/python
Setup ambari-server
Checking SELinux...
WARNING: Could not run /usr/sbin/sestatus: OK
Customize user account for ambari-server daemon [y/n] (n)? n <-----选择 n
Adjusting ambari-server permissions and ownership...
Checking firewall status...
Checking JDK...
[1] Oracle JDK 1.8 + Java Cryptography Extension (JCE) Policy Files 8
[2] Custom JDK
==============================================================================
Enter choice (1):
To download the Oracle JDK and the Java Cryptography Extension (JCE) Policy Files you must accept the license terms found at http://www.oracle.com/technetwork/java/javase/terms/license/index.html and not accepting will cancel the Ambari Server setup and you must install the JDK and JCE files manually.
Do you accept the Oracle Binary Code License Agreement [y/n] (y)? y
Downloading JDK from http://public-repo-1.hortonworks.com/ARTIFACTS/jdk-8u112-linux-x64.tar.gz to /var/lib/ambari-server/resources/jdk-8u112-linux-x64.tar.gz
jdk-8u112-linux-x64.tar.gz... 100% (174.7 MB of 174.7 MB)
Successfully downloaded JDK distribution to /var/lib/ambari-server/resources/jdk-8u112-linux-x64.tar.gz
Installing JDK to /usr/jdk64/
Successfully installed JDK to /usr/jdk64/
JCE Policy archive already exists, using /var/lib/ambari-server/resources/jce_policy-8.zip
Installing JCE policy...
Check JDK version for Ambari Server...
JDK version found: 8
Minimum JDK version is 8 for Ambari. Skipping to setup different JDK for Ambari Server.
Checking GPL software agreement...
GPL License for LZO: https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
Enable Ambari Server to download and install GPL Licensed LZO packages [y/n] (n)? y
Completing setup...
Configuring database...
Enter advanced database configuration [y/n] (n)? y <---选择y
Configuring database...
==============================================================================
Choose one of the following options:
[1] - PostgreSQL (Embedded)
[2] - Oracle
[3] - MySQL / MariaDB
[4] - PostgreSQL
[5] - Microsoft SQL Server (Tech Preview)
[6] - SQL Anywhere
[7] - BDB
==============================================================================
Enter choice (1): 3
Hostname (localhost): ambari-mysql.chenliujin.com
Port (3306):
Database name (ambari):
Username (ambari): root
Enter Database Password (bigdata):
Re-enter password:
Configuring ambari database...
Should ambari use existing default jdbc /usr/share/java/mysql-connector-java.jar [y/n] (y)? y
Configuring remote database connection properties...
WARNING: Before starting Ambari Server, you must run the following DDL against the database to create the schema: /var/lib/ambari-server/resources/Ambari-DDL-MySQL-CREATE.sql
Proceed with configuring remote database connection properties [y/n] (y)? y <---选择 y
Extracting system views...
.....
Ambari repo file contains latest json url http://public-repo-1.hortonworks.com/HDP/hdp_urlinfo.json, updating stacks repoinfos with it...
Adjusting ambari-server permissions and ownership...
Ambari Server 'setup' completed successfully.
```

# 启动
```
# ambari-server start
```

# 登陆

- URL: `http://127.0.0.1:8080`
- USERNAME: `admin`
- PASSWORD: `admin`

1. Launch Install Wizard
1. Select Version
 - HDP-2.6.5.0
 - HDFS: 2.7.3
 - HIVE: 1.2.1000
 - HBase: 1.1.2
 - Sqoop: 1.4.6
1. Install Options
1. Customize Services

输入 Hive, Grafana 的账号或密码

### Target Hosts

```
h4.chenliujin.com
```

### Host Registration Information

上传 ambari-server 服务器的 id_rsa 文件


# ambari-agent

## reset 

```
# ambari-agent stop
# ambari-agent reset ambari-server.chenliujin.com
```

## python 2.7.5版本不兼容

```
# vim /etc/ambari-agent/conf/ambari-agent.ini
[security]
ssl_verify_cert=0
force_https_protocol=PROTOCOL_TLSv1_2
```

# Service
- HDFS: 2.7.3
- YARN + MapReduce2: 2.7.3
- Tez: 0.7.0
- Hive: 1.2.1000
- HBase: 1.1.2
- Sqoop: 1.4.6
- ZooKeeper: 3.4.6


NameNode: ambari-h2
SNameNode: ambari-h3
DataNode: ambari-h3
HBase Master: ambari-h2




# 参考文件

- [HDP](https://zh.hortonworks.com/products/data-platforms/hdp/)
- http://blog.51cto.com/tryingstuff/2066561
