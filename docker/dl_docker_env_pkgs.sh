#!/bin/bash

set -e

# set up docker repository
echo "Setting up docker repository..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# update package list
echo "Updating package list..."
sudo apt-get update

# create a directory to store docker packages
mkdir -p deploy_pkg/docker-packages > /dev/null
cd deploy_pkg/docker-packages

# download docker packages
echo "Downloading docker packages..."
apt-get download docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin libip6tc2 libnetfilter-conntrack3 libnfnetlink0 iptables

# download docker-compose (x86_64 only here!!)
echo "Downloading docker-compose..."
curl -L "https://github.com/docker/compose/releases/download/v2.26.0/docker-compose-linux-x86_64" -o docker-compose
sudo chmod +x docker-compose

cd ../..
echo "Offline docker packages and docker-compose have been downloaded."
