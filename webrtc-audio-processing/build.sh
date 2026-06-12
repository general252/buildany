
git clone https://gitlab.freedesktop.org/pulseaudio/webrtc-audio-processing.git
cd webrtc-audio-processing

# 编译并安装到指定位置
meson setup build_windows_amd64 \
	--cross-file '../mingw_cross_windows_amd64.txt' \
	-Dcpp_args='["-DWEBRTC_WIN", "-DWEBRTC_ENABLE_SYMBOL_EXPORT", "-DWEBRTC_LIBRARY_IMPL", "-DWEBRTC_APM_DEBUG_DUMP"]' \
	-Dcpp_link_args='["-Wl,--export-all-symbols", "-Wl,--allow-multiple-definition", "-static-libgcc", "-static-libstdc++"]' \
	--default-library shared \
	--buildtype release \
	--prefix=${PWD}/dist_windows_amd64

# 开始编译
ninja -C build_windows_amd64 install

# 验证
x86_64-w64-mingw32-objdump -p dist_windows_amd64/bin/libwebrtc-audio-processing-2-1.dll | grep "DLL Name"
x86_64-w64-mingw32-nm -D dist_windows_amd64/bin/libwebrtc-audio-processing-2-1.dll | grep " T "
# 使用vs工具查看导出符合


# 编译并安装到指定位置
meson setup build_linux_amd64 \
	-Dcpp_args='["-DWEBRTC_ENABLE_SYMBOL_EXPORT", "-DWEBRTC_LIBRARY_IMPL", "-DWEBRTC_APM_DEBUG_DUMP"]' \
	-Dcpp_link_args='["-static-libgcc", "-static-libstdc++"]' \
	--default-library shared \
	--buildtype release \
	--prefix=${PWD}/dist_linux_amd64

# 开始编译
ninja -C build_linux_amd64 install




# 编译并安装到指定位置
meson setup build_linux_arm64 \
	--cross-file '../mingw_cross_linux_arm64.txt' \
	-Dcpp_args='["-DWEBRTC_ENABLE_SYMBOL_EXPORT", "-DWEBRTC_LIBRARY_IMPL", "-DWEBRTC_APM_DEBUG_DUMP"]' \
	-Dcpp_link_args='["-static-libgcc", "-static-libstdc++"]' \
	--default-library shared \
	--buildtype release \
	--prefix=${PWD}/dist_linux_arm64

# 开始编译
ninja -C build_linux_arm64 install
