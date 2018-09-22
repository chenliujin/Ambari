FROM centos:1.0.0

MAINTAINER chenliujin <liujin.chen@qq.com>

RUN curl http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.2.0/ambari.repo -o /etc/yum.repos.d/ambari.repo

RUN yum install -y ambari-agent

COPY ./etc/yum.repos.d /etc/yum.repos.d

RUN yum install -y hdp-select
RUN yum install -y ntp

RUN systemctl enable ntpd


COPY ./etc/ambari-agent/conf/ambari-agent.ini /etc/ambari-agent/conf/ambari-agent.ini


RUN echo "root:chenliujin" | chpasswd
