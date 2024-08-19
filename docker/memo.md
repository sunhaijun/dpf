### 外网环境

1. 下载、docker 环境离线文件安装包(按需)

   ```
   ./dl_docker_env_pkgs.sh
   ```

2. 下载/更新 离线docker 镜像文件（按需）

   ```
   ./dl_dep_imgs.sh
   ```

3. 下载开源大模型文件

   ```
   ./dl_ollama_models.sh
   ```

### 离线环境

1. 生成dpf-api, dpf-web docker image 文件

   ```
   ./gen_dpf_imgs\_[offline.sh](http://offline.sh)
   ./gen_dpf_imgs_offline.sh & disown
   ```

2. 制作部署包

   ```
   ./gen_deploy_pkg.sh
   ```

3. 部署(进入deploy_pkg目录)

   1. 复制deploy_pkg.tar.gz到目标机器，解压，执行：

      安装服务器docker环境[:](http://env.sh)

      ```
      ./prepare_docker_env.sh
      ```

   2. 加载docker镜像:

      ```
      ./load_docker_img.sh
      ```

   3. 启动 ollama 服务：

      ```
      ./start_ollama.sh
      ```

   4. 启动 dpf 服务:

      ```
      docker compose up -d
      ```

4. 其他

   1. 更新 dpf 镜像 仅需执行2.2, 2.3, 2.4即可。
   2. 升级大模型
      1. 外网环境下载更新的大模型
      2. 更新到离线环境 deploy_pkg/ollama内
      3. 重启 ollama docker容器以生效
      4. 按需修改dpf内模型配置