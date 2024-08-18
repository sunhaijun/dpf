#!/bin/bash

# 制作本地离线镜像文件
# 已支持：同时构建多个平台的镜像（linux/amd64, --linux/arm64）

set -e

app_version=0.7.0
platforms="linux/amd64"
log_file="result.log"

# 创建并使用新的构建器实例
docker buildx create --use > /dev/null 2>> $log_file
echo "Buildx instance created and in use." | tee -a $log_file

# 构建dpf-api版本 $app_version 的镜像并保存为本地离线文件
cd ../api
app_api_name="dpf-api"
echo "Start to build dpf-api..." | tee -a $log_file
#docker buildx build --platform $platforms -t ${app_api_name}:$app_version --build-arg APP_VERSION=$app_version --output type=oci,dest=${app_api_name}_${app_version}.tar . > /dev/null 2>> $log_file
docker buildx build --platform $platforms -t ${app_api_name}:$app_version --build-arg APP_VERSION=$app_version --load . > /dev/null 2>> $log_file
docker save -o ${app_api_name}_${app_version}.tar ${app_api_name}:$app_version
echo "Build and save ${app_api_name}:$app_version as ${app_api_name}_${app_version}.tar done." | tee -a $log_file
mv ${app_api_name}_${app_version}.tar ../docker/deploy_pkg/offline_images

# 构建dpf-web版本 $app_version 的镜像并保存为本地离线文件
cd ../web
app_web_name="dpf-web"
echo "Start to build dpf-web..." | tee -a $log_file
#docker buildx build --platform $platforms -t ${app_web_name}:$app_version --build-arg APP_VERSION=$app_version --output type=oci,dest=${app_web_name}_${app_version}.tar . > /dev/null 2>> $log_file
docker buildx build --platform $platforms -t ${app_web_name}:$app_version --build-arg APP_VERSION=$app_version --load . > /dev/null 2>> $log_file
docker save -o ${app_web_name}_${app_version}.tar ${app_web_name}:$app_version
echo "Build and save ${app_web_name}:$app_version as ${app_web_name}_${app_version}.tar done." | tee -a $log_file
mv ${app_web_name}_${app_version}.tar ../docker/deploy_pkg/offline_images

# 删除构建器实例
docker buildx rm  > /dev/null 2>> $log_file
echo "Buildx instance removed." | tee -a $log_file

cd ../docker

echo "All done." | tee -a $log_file