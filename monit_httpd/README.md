# monit_httpd

This container allows you to access monit running in the host machine via HTTP from another container.

## Usage

On Linux systems ⚠️ You have to bind your host applications to 0.0.0.0 or bridge network gateway in addition to
127.0.0.1. Use following docker command to get the bridge network gateway IP address

`docker network inspect bridge --format='{{( index .IPAM.Config 0).Gateway}}`

You might need to configure your firewall of the host system to allow the docker-host container to communicate with the
host on your relevant port:

```
sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' monit_httpd
$1
sudo ufw allow from $1 proto tcp to any port 2812
# or
sudo ufw allow 2812/tcp
```

