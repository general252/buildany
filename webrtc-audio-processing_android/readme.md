```shell
docker build -t webrtc-build-env .
docker run -it -v $(pwd):/build webrtc-build-env bash


# 下载并配置 NDK r21e (r21最后稳定版)
cd /opt
wget https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip \
    && unzip android-ndk-r21e-linux-x86_64.zip \
    && rm android-ndk-r21e-linux-x86_64.zip

export ANDROID_NDK_HOME=/opt/android-ndk-r21e

# 克隆仓库
git clone https://gitlab.freedesktop.org/pulseaudio/webrtc-audio-processing.git
cd webrtc-audio-processing
修改meson.build,将#subdir('examples')注释, 这是linux的示例

# 初始化构建目录 (强制设为 shared library)
meson setup build_android \
    --cross-file ../cross_android.ini \
	-Dcpp_args='["-fPIC", "-DWEBRTC_ENABLE_SYMBOL_EXPORT", "-DWEBRTC_LIBRARY_IMPL"]' \
    --default-library shared \
	-Dcpp_std=c++17 \
    -Dprefix=/build/output

ninja -C build_android
ninja -C build_android install

```

