# Adminer

Adminer (formerly phpMinAdmin) is a full-featured database management tool written in PHP. Adminer is available for
MySQL, MariaDB, PostgreSQL, SQLite, MS SQL, Oracle, Elasticsearch, MongoDB and others via plugin.

> default port: 8080

## Usage

- Don't specify the `postgres` database name on logging, that way you can switch between databases.

-------------------------------------------------------------------------------

# Setup in production environment

In production, we use `nginxproxy/nginx-proxy` to proxy the container `CONTAINER_PORT` to the internet.

## Prerequisites

- Reverse proxy network:
  - auto-reverse-proxy network `auto-reverse-proxy-global-network`.
- Required service networks:
  - postgres network `postgres_service-network`.
- Optional service networks:
  - redis network `redis_service-network`.

-------------------------------------------------------------------------------

# Setup in development environment

In development mode, the container `HOST_PORT` is exposed to localhost.

> No need for service networks since all containers are part of the shared network `l_shared-network`.