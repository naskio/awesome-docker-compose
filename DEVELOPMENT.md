# Development Mode (local)

## Manager

Install [docker-compose-manager](https://github.com/naskio/docker-compose-manager) (local version)

```shell
bash <(curl -sSL https://raw.githubusercontent.com/naskio/docker-compose-manager/main/install.sh) local
```

To use it, launch `dcm` command in your project directory.

## Setup

### Create global network called l_shared-network

```shell
docker network create l_shared-network
# undo using 
docker network rm l_shared-network
```

This network is used to connect all services to each other.

### Intra-cluster communication

Add all services to the same network `l_shared-network`.

> Services can be reachable in the same network at `$SERVICE_NAME:$CONTAINER_PORT`.

### Exposing services (UIs)

For exposing services to localhost, add `ports`to `docker-compose.local.yml` with value `$HOST_PORT:$CONTAINER_PORT`.

> We can access the service from `http://localhost:$HOST_PORT`.