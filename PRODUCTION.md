# Production Mode

## Manager

Install [docker-compose-manager](https://github.com/naskio/docker-compose-manager) on your server.

```shell
bash <(curl -sSL https://raw.githubusercontent.com/naskio/docker-compose-manager/main/install.sh)
```

To use it, launch `dcm` command in your project directory.

## Setup

### Create global network called auto-reverse-proxy-global-network

```shell
docker network create auto-reverse-proxy-global-network
# undo using 
docker network rm auto-reverse-proxy-global-network
```

This network is used to allow `nginxproxy/nginx-proxy` to proxy the containers and expose them to the internet.

### Intra-cluster communication

To enable intra-cluster communication, add the `${SERVICE_NAME}_service-network` network to the container for each
required service. We can also add optional services when the container is running by adding
the `${SERVICE_NAME}_service-network` network.

> Services can be reachable from within the container at `$SERVICE_NAME:$CONTAINER_PORT`.

### Exposing services (UIs)

For exposing services to the internet:

- add `expose`to `docker-compose.yml` with value `$CONTAINER_PORT`.
- add `VIRTUAL_PORT` to `docker-compose.yml` environment with the value of `$CONTAINER_PORT`.
- add `VIRTUAL_HOST` and `LETSENCRYPT_HOST` to `docker-compose.yml` environment with the value of `$DOMAIN_NAME`
  /`$SUBDOMAIN_NAME`.
- add `WEBMASTER_EMAIL` to `docker-compose.yml` environment with the value of `webmaster@$DOMAIN_NAME`.
- add container to network `auto-reverse-proxy-global-network`.

`$CONTAINER_PORT`: the port exposed by the container that will be reachable from the internet.
`$DOMAIN_NAME`: the domain name.

> We can access the service from `https://$DOMAIN_NAME`. The SSL/TLS certificate is automatically generated and renewed.
