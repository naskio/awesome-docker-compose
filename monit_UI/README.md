# Monit UI

Display monit status in a web UI. In order to monitor the single node where Docker is running.

> ⚠️ it is recommended to install monit directly on the host machine (don't run monit inside a docker container).

## Prerequisites

- Monit running on the host machine
    - check monit status `monit status`
- Monit configured to accept requests from the host machine
    - check monit config `cat /etc/monit/monitrc`
- Steps

```
apt update
apt install monit
cd /etc/monit/
chmod 700 /etc/monit/monitrc
# config monit
nano /etc/monit/monitrc
systemctl restart monit
systemctl enable monit
monit status
curl -I http://localhost:2812/
# add checks inside the folder /etc/monit/conf.d/XX
```

- Enable container to reach monit(reside in the host)

```
# get container-ip
sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' monit_UI
# allow container to reach monit in the firewall (to communicate with localhost:2812)
sudo ufw allow from <container-ip> proto tcp to any port 2812
# or all
sudo ufw allow 2812/tcp
```

## Credit

Inspired by [jwilder discussion for non docker](https://github.com/nginx-proxy/nginx-proxy/issues/998)
