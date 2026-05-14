FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    git \
    python3 \
    curl \
    wget \
    openjdk-17-jdk \
    build-essential \
    clang \
    ninja-build \
    pkg-config \
    unzip \
    xz-utils \
    file \
    ca-certificates \
    lsb-release \
    sudo \
	&& rm -rf /var/lib/apt/lists/* \
	&& git config --global --add safe.directory '*'

# depot_tools
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /opt/depot_tools

ENV PATH="/opt/depot_tools:${PATH}"

WORKDIR /workspace
