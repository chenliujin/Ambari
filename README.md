# 服务器列表
* dns.chenliujin.com
* mysql.chenliujin.com
* ambari.chenliujin.com 
* h1.chenliujin.com
* h2.chenliujin.com
* h3.chenliujin.com
* h4.chenliujin.com
* h5.chenliujin.com

## 1. Components 

### h1.chenliujin.com(node1.hadooptest.com)
* NameNode(HDFS)

### h2.chenliujin.com
* SNameNode(HDFS)
* Metrics Collector
* Grafana
* Activity Analyzer
* Activity Explorer
* HST Server

### h3.chenliujin.com
* DataNode(HDFS)
* ZooKeeper Server(ZooKeeper)
* App Timeline Server()
* ResourceManager()
* History Server()
* NodeManager()
* Hive Metastore(Hive)
* WebHCat Server
* HiveServer2(Hive)

### h4.chenliujin.com
* DataNode
* HBase Master(HBase)
* RegionServers(HBase)
* ZooKeeper Server(ZooKeeper)

### h5.chenliujin.com
* Spark2 History Server(Spark2)
* Spark2 Thrift Server(Spark2)
* Livy for Spark2 Server(Spark2)

---

# 高可用



# 下载包

```
http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.0.0/ambari-2.6.0.0-centos7.tar.gz
http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.5.0/HDP-2.6.5.0-centos7-rpm.tar.gz
http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos7/HDP-UTILS-1.1.0.21-centos7.tar.gz
```



---

# DNS Service

## 1. 安装 DNS Service

```
ansible-playbook dns.yml
```

## 2. 修改宿主服务器 DNS

```
# vim /etc/resolv.conf
nameserver 192.168.0.2 <---- 宿主服务器 IP
nameserver 114.114.114.114
nameserver 8.8.8.8

# chattr +i /etc/resolv.conf <--- read only
```

---

# MySQL 

- docker cp ambari-server:/var/lib/ambari-server/resources/Ambari-DDL-MySQL-CREATE.sql /root/

```
# mysql -h mysql.chenliujin.com -uroot -p
mysql > create database ambari;
mysql > CREATE USER 'ambari'@'%' IDENTIFIED BY 'chenliujin';
mysql > GRANT ALL PRIVILEGES on ambari.* to ambari@'%';
mysql > flush privileges;
mysql > use ambari;
mysql > source /root/Ambari-DDL-MySQL-CREATE.sql;
```

---

# ambari-server

- hostname: `ambari.chenliujin.com`

## 1. Docker Container

```
docker run \
  -d \
  --restart=always \
  --name=ambari \
  --network=ambari-network \
  --ip=192.168.100.99 \
  -h=ambari.chenliujin.com \
  chenliujin/ambari-server /usr/sbin/init
```

## 2. 初始化

```
# 修改 ulimit
# yum install -y mysql-connector-java

# ambari-server setup --api-ssl=false

Using python  /usr/bin/python
Setup ambari-server
Checking SELinux...
WARNING: Could not run /usr/sbin/sestatus: OK
Customize user account for ambari-server daemon [y/n] (n)? <-----默认，回车
Adjusting ambari-server permissions and ownership...
Checking firewall status...
Checking JDK...
[1] Oracle JDK 1.8 + Java Cryptography Extension (JCE) Policy Files 8
[2] Custom JDK
==============================================================================
Enter choice (1): <-----默认1，回车
To download the Oracle JDK and the Java Cryptography Extension (JCE) Policy Files you must accept the license terms found at http://www.oracle.com/technetwork/java/javase/terms/license/index.html and not accepting will cancel the Ambari Server setup and you must install the JDK and JCE files manually.
Do you accept the Oracle Binary Code License Agreement [y/n] (y)? <-----默认y，回车
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
Enable Ambari Server to download and install GPL Licensed LZO packages [y/n] (n)? <-----选择y，回车
Completing setup...
Configuring database...
Enter advanced database configuration [y/n] (n)? y <-----选择 y，回车
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
Enter choice (1): 3 <-----选择3，回车
Hostname (localhost): mysql.chenliujin.com <-----输入mysql.chenliujin.com，回车
Port (3306): <-----使用默认端口，回车
Database name (ambari): <-----默认，回车
Username (ambari): <---- 默认，回车
Enter Database Password (bigdata): chenliujin <---- 输入数据库密码
Re-enter password: <-----确认密码
Configuring ambari database...
Should ambari use existing default jdbc /usr/share/java/mysql-connector-java.jar [y/n] (y)? y
Configuring remote database connection properties...
WARNING: Before starting Ambari Server, you must run the following DDL against the database to create the schema: /var/lib/ambari-server/resources/Ambari-DDL-MySQL-CREATE.sql <---- 需要初始化 ambari 数据库
Proceed with configuring remote database connection properties [y/n] (y)? y <---选择 y
Extracting system views...
ambari-admin-2.6.2.0.155.jar
...........
Adjusting ambari-server permissions and ownership...
Ambari Server 'setup' completed successfully.
```

## 3. 启动

```
# ambari-server setup --jdbc-db=mysql --jdbc-driver=/usr/share/java/mysql-connector-java.jar
# ambari-server start
```

## 4. 无密码登陆

```
ssh-copy-id h1.chenliujin.com
ssh-copy-id h2.chenliujin.com
ssh-copy-id h3.chenliujin.com
```

---

# 集群安装

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
1. Customize Services

输入 Hive, Grafana 的账号或密码

## Install Options

### Target Hosts

```
h1.chenliujin.com
h2.chenliujin.com
h3.chenliujin.com
```

### Host Registration Information

上传 ambari-server 服务器的 id_rsa 文件

---

# Service
- HDFS: 2.7.3
- YARN + MapReduce2: 2.7.3
- Tez: 0.7.0
- Hive: 1.2.1000
- HBase: 1.1.2
- Sqoop: 1.4.6
- ZooKeeper: 3.4.6


# 注意事项
* hyper-v 网络适配器使用默认开关，否则虚拟机之间的网络通信会不稳定



# 参考文件

- [HDP](https://zh.hortonworks.com/products/data-platforms/hdp/)
- http://blog.51cto.com/tryingstuff/2066561
- [CentOS7上本地源方式安装Ambari-2.5.2.0+HDP-2.6.2.0](https://blog.csdn.net/sunggff/article/details/78933632)
