# Telegraf

> > ⚠️ it is recommended to install Telegraf directly on the host machine (don't run telegraf inside a docker container).

Agent for collecting data and ingest it into InfluxDB.

Configured with the following plugins:

- inputs
    - monit (running in the host machine)
    - docker (running in the host machine)
- outputs
    - influxdb

## Check if telegraf is running

```
docker exec -it telegraf bash
telegraf -test -config /etc/telegraf/telegraf.conf -config-directory /etc/telegraf/telegraf.d/
```

## Display logs

```
/telegraf_logs/_data/telegraf.log
```