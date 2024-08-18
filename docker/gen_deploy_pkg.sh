#!/bin/bash

# 提示文本颜色
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
PLAIN='\033[0m'

# 提示文本
red() {
    echo -e "\033[31m\033[01m$1\033[0m"
}
green() {
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}


yellow "Generating deploy package..."
cp .env.example deploy_pkg/.env
cp docker-compose.yml deploy_pkg/docker-compose.yml
cp prepare_docker_env.sh deploy_pkg/
cp load_dep_imgs.sh deploy_pkg/
cp -r ssrf_proxy deploy_pkg/
cp -r volumes deploy_pkg/

yellow "Compressing deploy package..."
tar -czf deploy_pkg.tar.gz deploy_pkg

green "Deploy package deploy_pkg.tar.gz has been generated."