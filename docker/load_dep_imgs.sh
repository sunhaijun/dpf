#!/bin/bash

set -e

# 定义镜像文件夹
image_folder="offline_images"

# 检查文件夹是否存在
if [ ! -d "$image_folder" ]; then
    echo "Folder $image_folder does not exist."
    exit 1
fi

# 加载镜像
echo "Loading images from $image_folder..."
for image_file in "$image_folder"/*.tar; do
    echo "Loading image from $image_file..."
    docker load -i "$image_file"
done

echo "All images have been loaded into the local Docker environment."