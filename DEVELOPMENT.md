# Development Mode (local)

## Manager

Install [docker-compose-manager](https://github.com/naskio/docker-compose-manager) (local version)

```shell
bash <(curl -sSL https://raw.githubusercontent.com/naskio/docker-compose-manager/main/install.sh) local
```

To use it, launch `dcm` command in your project directory.

## Setup Overview

### A shared network for communication between containers

We create a network called `l_shared-network`. This network is used to connect all services to each other.

```shell
docker network create l_shared-network
# undo using 
docker network rm l_shared-network
```

### How we enable intra-cluster communication ?

We connect all services to the same network `l_shared-network`.

> Services can be reachable in the same network at `$SERVICE_NAME:$CONTAINER_PORT`.

### How we expose services to localhost ?

For exposing services to localhost, we add `ports`to `docker-compose.local.yml` with value `$HOST_PORT:$CONTAINER_PORT`.

> We can access the service from `http://localhost:$HOST_PORT`.