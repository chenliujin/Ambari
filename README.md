# Yum 

```
curl http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.2.0/ambari.repo -o /etc/yum.repos.d/ambari.repo
```

# Install

## 1. ambari-server
```
# yum install -y ambari-server
```

## 2. MySQL Connector

```
yum install -y mysql-connector-java

ln -s /usr/share/java/mysql-connector-java.jar /var/lib/ambari-server/resources/mysql-connector-java.jar
```

# MySQL

```
# mysql -h 127.0.0.1 -uroot -p
mysql > create database ambari;
mysql > use ambari;
mysql > source /root/Ambari-DDL-MySQL-CREATE.sql;

mysql -h 127.0.0.1 -uroot -p ambari < /var/lib/ambari-server/resources/Ambari-DDL-MySQL-CREATE.sql
```


# 初始化

```
# ambari-server setup --api-ssl=false

Using python  /usr/bin/python
Setup ambari-server
Checking SELinux...
WARNING: Could not run /usr/sbin/sestatus: OK
Customize user account for ambari-server daemon [y/n] (n)? n
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
Enter advanced database configuration [y/n] (n)? y
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
Hostname (localhost): 192.168.0.155
Port (3306):
Database name (ambari):
Username (ambari): root
Enter Database Password (bigdata):
Re-enter password:
Configuring ambari database...
Should ambari use existing default jdbc /usr/share/java/mysql-connector-java.jar [y/n] (y)? y
Configuring remote database connection properties...
WARNING: Before starting Ambari Server, you must run the following DDL against the database to create the schema: /var/lib/ambari-server/resources/Ambari-DDL-MySQL-CREATE.sql
Proceed with configuring remote database connection properties [y/n] (y)? y
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
2. Install Options

### Target Hosts

```
hadoop-slave1
hadoop-slave2
```

### Host Registration Information

上传 ambari-server 服务器的 id_rsa 文件




# 参考文件

- [HDP](https://zh.hortonworks.com/products/data-platforms/hdp/)
- http://blog.51cto.com/tryingstuff/2066561
