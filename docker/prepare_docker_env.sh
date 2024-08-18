#!/bin/bash

set -e

cd deploy_pkg/docker-packages
echo "Installing docker packages..."
sudo dpkg -i *.deb

echo "Adding user(sun) to docker group..."
sudo usermod -aG docker sun

echo "Checking docker service status..."
sudo systemctl is-active docker

echo "Installing docker-compose..."
sudo cp docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

docker --version
docker-compose --version

cd ../..

echo "Done."