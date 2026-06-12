FROM ubuntu:22.04

# 设置环境变量，避免交互式安装时的提示
ENV DEBIAN_FRONTEND=noninteractive

# ==============================================================================
# 1. 安装基础构建工具 (Linux 本地编译及通用工具)
# ==============================================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    git \
    wget \
    curl \
    zip \
    unzip \
    nasm \
    cmake \
    ninja-build \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    && rm -rf /var/lib/apt/lists/*

# ==============================================================================
# 2. 安装 Windows amd64 交叉编译工具链 (MinGW-w64)
# ==============================================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    mingw-w64 \
    g++-mingw-w64 \
    gcc-mingw-w64 \
    binutils-mingw-w64 \
    wine64 \
    && rm -rf /var/lib/apt/lists/*

# 设置 MinGW 默认使用 posix 线程模型（对 C++11 std::thread 等支持更好）
RUN update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix \
    && update-alternatives --set x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix

# ==============================================================================
# 3. 安装 Linux arm64 (aarch64) 交叉编译工具链
# ==============================================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    binutils-aarch64-linux-gnu \
    && rm -rf /var/lib/apt/lists/*

# ==============================================================================
# 4. 安装构建系统依赖 (Meson)
# ==============================================================================
RUN pip3 install --no-cache-dir meson

WORKDIR /home
CMD ["bash"]