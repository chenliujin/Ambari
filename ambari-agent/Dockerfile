FROM centos:1.0.0

MAINTAINER chenliujin <liujin.chen@qq.com>

COPY ./etc/yum.repos.d/ambari.repo /etc/yum.repos.d/ambari.repo

RUN yum install -y ambari-agent

# 配置兼容，参考 README.md
COPY ./etc/ambari-agent /etc/ambari-agent

RUN echo "root:chenliujin" | chpasswd
