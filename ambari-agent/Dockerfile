FROM centos:1.0.0

MAINTAINER chenliujin <liujin.chen@qq.com>

COPY ./etc/yum.repos.d /etc/yum.repos.d

RUN yum install -y ambari-agent

COPY ./etc/ambari-agent /etc/ambari-agent

RUN echo "root:chenliujin" | chpasswd
