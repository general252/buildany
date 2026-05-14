FROM ubuntu:22.04

# 安装基础构建工具
RUN apt-get update && apt-get install -y \
    git python3 python3-pip ninja-build wget unzip pkg-config \
    && pip3 install meson

# 设置工作目录
WORKDIR /build