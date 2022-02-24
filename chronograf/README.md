# Chronograf

UI for InfluxDB v1+ (InfluxDB v2 comes with a UI built-in).

> default port: 8888

## Usage

- UI for InfluxDB v1+ (deprecated)

-------------------------------------------------------------------------------

# Setup in production environment

In production, we use `nginxproxy/nginx-proxy` to proxy the container from `CONTAINER_PORT` to the internet.

## Prerequisites

- Reverse proxy network:
  - auto-reverse-proxy network `auto-reverse-proxy-global-network`.
- Required service networks:
  - InfluxDB network `influxdb_service-network`.

-------------------------------------------------------------------------------

# Setup in development environment

In development mode, the container is exposed to localhost at `HOST_PORT`.

> No need for service networks since all containers are part of the shared network `l_shared-network`.

