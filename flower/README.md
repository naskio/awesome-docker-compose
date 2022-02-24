# Flower

Flower enables you to monitor your celery workers and tasks, and see the results

## Prerequisites

- Usage of `nginxproxy/nginx-proxy`
- Celery workers running
- RabbitMQ as broker
- existing docker networks `auto-reverse-proxy-global-network` and `rabbitmq_service-network`

> We can use `redis` as broker.

## Notes

All Celery
settings ([the list is available here](https://docs.celeryproject.org/en/latest/userguide/configuration.html#new-lowercase-settings))
can be set via environment variables. In capital letters, prefixed with CELERY_. For example, to set broker_url, use the
CELERY_BROKER_URL environment variable. The Flower specific settings can also be set via environment
variables. [A full list is available here](https://flower.readthedocs.io/en/latest/config.html#options), uppercase the
variable and prefix with FLOWER_. For instance, to configure port, use the FLOWER_PORT environment variable.

# Credits

Inspired
from [dockerize-celery-django-app](https://github.com/bstiel/dockerize-celery-django-app/blob/master/docker-compose.yml)