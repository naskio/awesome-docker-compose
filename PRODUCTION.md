# Production Mode

## Manager

Install [docker-compose-manager](https://github.com/naskio/docker-compose-manager) on your server.

```shell
bash <(curl -sSL https://raw.githubusercontent.com/naskio/docker-compose-manager/main/install.sh)
```

To use it, launch `dcm` command in your project directory.

## Setup Overview

### A global network for proxying

We create a global network called `auto-reverse-proxy-global-network`. This network is used to
allow `nginxproxy/nginx-proxy` to proxy the containers and expose them to the internet.

```shell
docker network create auto-reverse-proxy-global-network
# undo using 
docker network rm auto-reverse-proxy-global-network
```

### How we enable intra-cluster communication ?

To enable intra-cluster communication, we create a network `${SERVICE_NAME}_service-network` for each backend service.
Then we connect the container if it depends on this service to the service network (required service). We can also add
optional services when the container is running by connecting the `${SERVICE_NAME}_service-network` network using the
command `docker network connect ${SERVICE_NAME}_service-network ${CONTAINER_NAME}` or via `Portainer`.

> Services can be reachable from within the container at `$SERVICE_NAME:$CONTAINER_PORT`.

### How we expose services to the internet ?

For exposing services to the internet:

- we add `expose`to `docker-compose.yml` with value `$CONTAINER_PORT`.
- we add `VIRTUAL_PORT` to `docker-compose.yml` environment with the value of `$CONTAINER_PORT`.
- we add `VIRTUAL_HOST` and `LETSENCRYPT_HOST` to `docker-compose.yml` environment with the value of `$DOMAIN_NAME`
  or `$SUBDOMAIN_NAME`.
- we add `WEBMASTER_EMAIL` to `docker-compose.yml` environment with the value of `webmaster@$DOMAIN_NAME`.
- we connect the service to the network `auto-reverse-proxy-global-network`.

`$CONTAINER_PORT`: the port exposed by the container that will be reachable from the internet.
`$DOMAIN_NAME`: the domain name.

> We can access the service from `https://$DOMAIN_NAME`. The SSL/TLS certificate is automatically generated and renewed while using [auto-reverse-proxy](https://github.com/naskio/docker-nginx-auto-reverse-proxy/blob/main/nginx-proxy/docker-compose.yml).
