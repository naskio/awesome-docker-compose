# Prometheus

Prometheus is a tool for large-scale monitoring.

## Prerequisites

- Usage of `nginxproxy/nginx-proxy`
- existing docker networks `auto-reverse-proxy-global-network`

### Timeseries database

- (prometheus)[https://prometheus.io/] is used to store the data.
    - We use nginxproxy/nginx-proxy to deploy Prometheus as docker container.

### Exporters

Exporters are used to collect metrics from the system, host or container and expose them in an HTTP endpoint `/metrics`
so it will be possible for Prometheus to scrape them.

- [node_exporter](https://github.com/prometheus/node_exporter) to collect and expose data to Prometheus.
    - Download the binary and install it in the host machine.
- [cadvisor](https://prometheus.io/docs/guides/cadvisor/)
    - short for [container advisor](https://github.com/google/cadvisor)
    - analyzes and exposes resource usage and performance data from running containers. cAdvisor exposes Prometheus
      metrics out of the box.
- [blackbox_exporter](https://github.com/prometheus/blackbox_exporter)
    - The blackbox exporter allows blackbox probing of endpoints over HTTP, HTTPS, DNS, TCP and ICMP.

Exporters are targets for Prometheus to scrape.

### Data Visualization

We can use:

- [grafana](https://prometheus.io/docs/visualization/grafana/) to visualize the data.
    - We use nginxproxy/nginx-proxy to deploy Grafana as docker container.
- [Expression browser](https://prometheus.io/docs/introduction/exposition_formats/#expression-browser) to visualize the
  data.
    - [/graph](https://prometheus.io/docs/visualization/browser/)
    - The expression browser is available at `/graph` on the Prometheus server, allowing you to enter any expression and
      see its result either in a table or graphed over time.
    - This is primarily useful for ad-hoc queries and debugging.
- For graphs, use Grafana or Console templates.
- [CONSOLE TEMPLATES](https://prometheus.io/docs/visualization/consoles/)

### Alert manager

[Prometheus Alertmanager](https://github.com/prometheus/alertmanager)
The Alertmanager handles alerts sent by client applications such as the Prometheus server. It takes care of
deduplicating, grouping, and routing them to the correct receiver integrations such as email, PagerDuty, or OpsGenie. It
also takes care of silencing and inhibition of alerts.

### Pushgateway

[Prometheus Pushgateway](https://github.com/prometheus/pushgateway)

The Prometheus Pushgateway exists to allow ephemeral and batch jobs to expose their metrics to Prometheus. Since these
kinds of jobs may not exist long enough to be scraped, they can instead push their metrics to a Pushgateway. The
Pushgateway then exposes these metrics to Prometheus.

> because Prometheus is the responsible for scraping the metrics from the targets (exporters, pushgateway, etc.)
> Prometheus is also a target since it exposes its metrics throw /metrics endpoint.

---------------------------------------------------------------------------------------------------------------

# Integration with InfluxDB v2

Use [telegraf](https://docs.influxdata.com/influxdb/v2.1/write-data/developer-tools/scrape-prometheus-metrics/) input
plugin to scrape Prometheus metrics.

or using scrapers: InfluxDB scrapers can collect data from any HTTP(S)-accessible endpoint that returns data in the
Prometheus data format. This article provides links to information about the Prometheus data format and tools that
generate Prometheus-formatted metrics.

InfluxDB scrapers automatically scrape Prometheus-formatted metrics from an HTTP-accessible endpoint (
usually `/metrics`) at a regular interval. For information about setting up an InfluxDB scraper,
see [Scrape data using InfluxDB scrapers](https://docs.influxdata.com/influxdb/v2.1/write-data/no-code/scrape-data/).

# Acknowledgement

[Prometheus monitoring](https://blog.ouidou.fr/un-monitoring-complet-en-quelques-minutes-avec-prometheus-33e849e6392e)