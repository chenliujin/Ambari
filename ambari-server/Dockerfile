FROM centos:1.0.0

MAINTAINER chenliujin <liujin.chen@qq.com>

COPY ./etc/yum.repos.d /etc/yum.repos.d

RUN yum install -y ntp
RUN yum install -y ambari-server
RUN yum install -y mysql-connector-java

RUN ln -s /usr/share/java/mysql-connector-java.jar /var/lib/ambari-server/resources/mysql-connector-java.jar
RUN systemctl enable ntpd
RUN echo "root:chenliujin" | chpasswd

COPY ./etc/ambari-agent/conf/ambari-agent.ini /etc/ambari-agent/conf/ambari-agent.ini
