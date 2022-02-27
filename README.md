# Awesome Docker Compose [![Awesome](https://awesome.re/badge.svg)](https://www.github.com/naskio/awesome-docker-compose)

Collection of awesome Docker Compose files `docker-compose.yml`.

## Summary

This collection can be used locally for development or in production (ready to be used with `nginxproxy/nginx-proxy`) or
to find ready-to-use Docker Compose files.

- [Development setup overview](./DEVELOPMENT.md)
- [Production setup overview](./PRODUCTION.md)

--------------------------------------------------------------------------------

## Usage

### Development mode

**Prerequisites**:

- The shared network `l_shared-network` exists, use the command `docker network create l_shared-network` to create it.

To use a service from this collection in development mode:

- Go to the service folder `cd $SERVICE_NAME`.
- Configure the env variables in the `.env` file inside the service folder `cp .env.example.local .env`.
- Then you can run `docker-compose` commands. In local mode we should always specify the `-f` flag to use
  the `docker-compose.local.yml` file:
  - `docker-compose -f docker-compose.local.yml up -d` to start the service.
  - `docker-compose -f docker-compose.local.yml exec -it $SERVICE_NAME bash` to access the service.
  - `docker-compose -f docker-compose.local.yml down` to stop the service.

> You can use [docker-compose-manager (local version)](https://github.com/naskio/docker-compose-manager) to run `docker-compose` commands easily.

### Production mode

**Prerequisites**:

- Usage of [auto-reverse-proxy](https://github.com/naskio/docker-nginx-auto-reverse-proxy) for reverse proxying and
  managing SSL/TLS certificates.
  - The global network `auto-reverse-proxy-global-network` exists.
  - The container `nginx-proxy` up and running.

To use a service from this collection in production mode:

- Go to the service folder `cd $SERVICE_NAME`.
- Configure the env variables in the `.env` file inside the service folder `cp .env.example .env`.
- Then you can run `docker-compose` commands:
  - `docker-compose up -d` to start the service.
  - `docker-compose exec -it $SERVICE_NAME bash` to access the service.
  - `docker-compose down` to stop the service.

> You can use [docker-compose-manager](https://github.com/naskio/docker-compose-manager) to run `docker-compose` commands easily.

--------------------------------------------------------------------------------

## Available services

- [Adminer](./adminer): (formerly phpMinAdmin) is a full-featured database management tool written in PHP.
- [adminMongo](./adminmongo): web-based user interface for MongoDB.
- [ElasticSearch](./elasticsearch): full-text search and analytics engine.

TODO: complete the available services list.

### Adding a new service

To add a new service to this collection, please read [DEVELOPMENT SETUP](./DEVELOPMENT.md)
and [PRODUCTION SETUP](./PRODUCTION.md) files and get inspired from existing services.

--------------------------------------------------------------------------------

## Contributing

Pull requests are welcome. For any issue, please open an issue
on [GitHub](https://www.github.com/naskio/awesome-docker-compose/issues).

See the [contributor guide](./CONTRIBUTING.md) for more information.

## License

[MIT License](./LICENSE)