# Graphite

A highly scalable real-time graphing system [graphite.readthedocs.org/](graphite.readthedocs.org/)

```
docker run -d\
 --name graphite\
 --restart=always\
 -p 80:80\
 -p 2003-2004:2003-2004\
 -p 2023-2024:2023-2024\
 -p 8125:8125/udp\
 -p 8126:8126\
 graphiteapp/graphite-statsd
```

[docker-graphite-statsd](https://github.com/graphite-project/docker-graphite-statsd)
[Installing Graphite](https://graphite.readthedocs.io/en/stable/install.html)
[Docker Hub](https://hub.docker.com/r/graphiteapp/graphite-statsd/)