
FROM ubuntu:22.04

# 设置环境变量，避免交互式安装时的提示
ENV DEBIAN_FRONTEND=noninteractive

# 1. 安装基础构建工具 (Linux 本地编译)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    git \
    wget \
    nasm \
    cmake \
    ninja-build \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    curl \
    wget \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 2. 安装 Windows 交叉编译工具链 (MinGW-w64)
RUN apt-get update && apt-get install -y \
	mingw-w64 \
    g++-mingw-w64 \
	gcc-mingw-w64 \
	binutils-mingw-w64 \
	wine64 \
	&& rm -rf /var/lib/apt/lists/*

RUN    update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix \
	&& update-alternatives --set x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix

# 使用 pip 安装最新版 meson（或者指定版本，如 meson==0.63.0）
RUN pip3 install --no-cache-dir meson

WORKDIR /home
CMD ["bash"]

