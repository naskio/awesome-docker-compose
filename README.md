# docker-backend-services

Docker compose declarations for different backend services such as: MongoDB, Redis, Postgres, etc.

# Step-by-step guide

- Start by configuring the env variables in the `.env` file inside the service folder.
- Then, run `docker-compose up -d` to start the service.
- Then, run `docker-compose exec -it backend-services bash` to access the service.
- To stop the service, run `docker-compose down`.

