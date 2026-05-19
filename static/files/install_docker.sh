#!/bin/bash

set -euo pipefail

cd /tmp/
mkdir -p docker-tmp
cd docker-tmp

wget https://dl.gooy.site/docker-29.3.1.tgz
wget https://dl.gooy.site/docker.service

tar xvf docker-29.3.1.tgz

mv docker/* /usr/bin/
mv docker.service /etc/systemd/system/docker.service

# install docker compose

DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://dl.gooy.site/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

systemctl daemon-reload

systemctl enable --now docker

(docker ps && \
docker compose version && \
echo "Docker and Docker Compose have been installed successfully.") || \
(echo "Docker installation failed. Please check the logs for details." && exit 1)
