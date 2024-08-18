#!/bin/bash

# 定义镜像文件夹
image_folder="offline_images"

# 检查文件夹是否存在
if [ ! -d "$image_folder" ]; then
    echo "Folder $image_folder does not exist."
    exit 1
fi

# 删除dpf-开头的docker镜像
echo "Removing images..."
docker images | grep dpf- | awk '{print $3}' | xargs docker rmi -f

# 加载dpf-开头的文件镜像
echo "Loading images from $image_folder..."
for image_file in "$image_folder"/dpf-*.tar; do
    echo "Loading image from $image_file..."
    docker load -i "$image_file"
done

echo "All dpf images loaded."