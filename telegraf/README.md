# Telegraf

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
telegraf -config /etc/telegraf/telegraf.conf -test
```
