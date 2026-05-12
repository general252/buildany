# 1. 准备源码
git clone --depth 1 https://github.com/xiph/rnnoise.git
cd rnnoise
./autogen.sh

# 2. 配置动态库编译
# --enable-shared: 产生 .dll
# --disable-static: 如果你不需要 .a 文件可以关闭，减少编译时间
# LDFLAGS: 确保导出符号，-no-undefined 是 Libtool 在交叉编译 DLL 时的硬性要求
# 清理旧的编译结果
make clean

# 针对现代 x64 架构进行优化
./configure \
    --host=x86_64-w64-mingw32 \
    --prefix=$(pwd)/dist_win64 \
    --enable-shared \
    --disable-static \
    LDFLAGS="-Wl,-no-undefined -static-libgcc" \
    CFLAGS="-O3 -march=haswell -mtune=haswell -mfpmath=sse"

# 3. 编译
make -j$(nproc)
make install
