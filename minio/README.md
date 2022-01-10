# MinIO

minio server available at port 9000.

MinIO Server comes with an embedded web based object browser. Point your web browser to http://127.0.0.1:9000 to ensure
your server has started successfully.

# minIO Console

minio/console is a web based console for managing minio server. it is available at port 9001.

## Root user

The MinIO deployment starts using default root credentials (unless override) minioadmin:minioadmin. You can test the
deployment using the MinIO Console, an embedded object browser built into MinIO Server. Point a web browser running on
the host machine to http://127.0.0.1:9000 and log in with the root credentials. You can use the Browser to create
buckets, upload objects, and browse the contents of the MinIO server.

Rotating the root user credentials requires updating either or both variables for all MinIO servers in the deployment.
Specify long, unique, and random strings for root credentials. Exercise all possible precautions in storing the access
key and secret key, such that only known and trusted individuals who require superuser access to the deployment can
retrieve the root credentials.

