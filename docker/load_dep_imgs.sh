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

# 定义镜像文件夹
image_folder="offline_images"

# 检查文件夹是否存在
if [ ! -d "$image_folder" ]; then
    echo "Folder $image_folder does not exist."
    exit 1
fi

# 加载镜像
yellow "Loading images from $image_folder..."
for image_file in "$image_folder"/*.tar; do
    echo "Loading image from $image_file..."
    docker load -i "$image_file"
done

green "All images have been loaded into the local Docker environment."