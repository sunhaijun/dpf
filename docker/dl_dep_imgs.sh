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

# 创建 offline_images 文件夹
mkdir -p deploy_pkg/offline_images > /dev/null

# 定义需要下载的镜像列表
images=(
    "postgres:15-alpine"
    "redis:6-alpine"
    "langgenius/dify-sandbox:0.2.1"
    "ubuntu/squid:latest"
    "semitechnologies/weaviate:1.19.0"
    # "certbot/certbot"
    # "nginx:latest"
    # "langgenius/qdrant:v1.7.3"
    # "pgvector/pgvector:pg16"
    # "tensorchord/pgvecto-rs:pg16-v0.3.0"
    # "ghcr.io/chroma-core/chroma:0.5.1"
    # "container-registry.oracle.com/database/free:latest"
    # "quay.io/coreos/etcd:v3.5.5"
    # "minio/minio:RELEASE.2023-03-20T20-16-18Z"
    # "milvusdb/milvus:v2.3.1"
    # "opensearchproject/opensearch:latest"
    # "opensearchproject/opensearch-dashboards:latest"
    # "myscale/myscaledb:1.6.4"
    # "docker.elastic.co/elasticsearch/elasticsearch:8.14.3"
    # "docker.elastic.co/kibana/kibana:8.14.3"
    # "downloads.unstructured.io/unstructured-io/unstructured-api:latest"
    # 在此添加更多镜像
)

# 下载并保存镜像
yellow "Downloading images..."
for image in "${images[@]}"; do
    echo "Pulling image $image..."
    docker pull $image
    image_name=$(echo $image | tr '/' '_' | tr ':' '_')
    echo "Saving image $image to deploy_pkg/offline_images/${image_name}.tar..."
    docker save -o "deploy_pkg/offline_images/${image_name}.tar" $image
done

green "All images have been downloaded and saved to offline_images folder."