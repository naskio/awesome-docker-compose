# docker-backend-services

Docker compose declarations for different backend services such as: MongoDB, Redis, Postgres, etc.

## Step-by-step guide

- Start by configuring the env variables in the `.env` file inside the service folder.
- Then, run `docker-compose up -d` to start the service.
- Then, run `docker-compose exec -it backend-services bash` to access the service.
- To stop the service, run `docker-compose down`.

## Usage

In order to connect your app with any service, you need to add the following to your `docker-compose.yml` file:

- Your app service should be in the same network with the service specific network `${SERVICE_NAME}_service-network`.
- Connect to the service using the connection string `${PROTOCOL}://${SERVICE_NAME}:{$CONTAINER_PORT}/`.

- For example, to connect the app to:
    - MongoDB service, you can use the connection string `mongodb://mongodb:27017/`.
    - Redis service, you can use the connection string `redis://redis:6379/`.
    - Postgres service, you can use the connection string `postgres://postgres:5432/`.
    - Postgis service, you can use the connection string `postgres://postgres:5432/`.
    - MySQL service, you can use the connection string `mysql://mysql:3306/`.
    - Elasticsearch service, you can use the connection string `http://elasticsearch:9200/`.
    - Minio service, you can use the connection string `http://minio:9000/`.
    - RabbitMQ service, you can use the connection string `amqp://rabbitmq:5672/`.

- In order to use adminer, go to `https://{VIRTUAL_HOST}/`.
- In order to use kibana, go to `https://{VIRTUAL_HOST}/`.
- In order to use rabbitmq manager, go to `https://{VIRTUAL_HOST}/`.
- In order to use Grafana, go to `https://{VIRTUAL_HOST}/`.

## Alternative strategy

Define all services in one `docker-compose.yml` file, and then run `docker-compose up -d` to start all services or start
only few services `docker-compose up -d minio`
