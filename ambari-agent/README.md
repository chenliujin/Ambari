# ambari-agent 所在服务器重启后重新加入集群

```
# ambari-agent stop
# ambari-agent reset ambari.chenliujin.com
# systemctl start ambari-agent
```

# ambari.repo

curl http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.2.0/ambari.repo -o /etc/yum.repos.d/ambari.repo

# python 2.7.5版本不兼容

```
# vim /etc/ambari-agent/conf/ambari-agent.ini
[security]
ssl_verify_cert=0
force_https_protocol=PROTOCOL_TLSv1_2
```


