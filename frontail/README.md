# frontail

Display a log file in a web browser

> default port: 9001

## Usage

- Set `LOG_FILE` to the path of the log file to display. (host machine where Docker Compose is running).

-------------------------------------------------------------------------------

# Setup in production environment

In production, we use `nginxproxy/nginx-proxy` to proxy the container from `CONTAINER_PORT` to the internet.

## Prerequisites

- Reverse proxy network:
  - auto-reverse-proxy network `auto-reverse-proxy-global-network`.

-------------------------------------------------------------------------------

# Setup in development environment

In development mode, the container is exposed to localhost at `HOST_PORT`.

> No need for service networks since all containers are part of the shared network `l_shared-network`.


