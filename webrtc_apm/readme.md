



```shell
# docker build -t webrtc-android .
```


```
# fetch --nohooks webrtc_android
# gclient sync
# git checkout branch-heads/5993
# gclient runhooks
# gclient sync -D
```

创建`src/modules/audio_processing/build_apm_android/BUILD.gn`
```
import("//build/config/android/config.gni")

shared_library("webrtc_apm") {

  output_name = "webrtc_apm"

  sources = [
    "dummy.cc",
  ]

  deps = [
    "//modules/audio_processing:audio_processing",
  ]

  configs += [
    "//build/config/compiler:default_optimization",
  ]
}
```

dummy.cc
```
extern "C" void webrtc_apm_dummy() {}
```

```
mkdir -p out/android_arm64

gn gen out/android_arm64 --args='
target_os="android"
target_cpu="arm64"

is_debug=false
is_component_build=false

rtc_include_tests=false
rtc_build_examples=false
rtc_build_tools=false
rtc_enable_protobuf=false
rtc_include_builtin_audio_codecs=false
rtc_include_builtin_video_codecs=false

rtc_build_ssl=false
rtc_ssl_root=""

rtc_enable_sctp=false
rtc_build_dcsctp=false

rtc_enable_avx2=false

use_rtti=true
use_custom_libcxx=false

is_clang=true

symbol_level=0

android_channel="stable"
'


ninja -C out/android_arm64 webrtc_apm

out/android_arm64/libwebrtc_apm.so
nm -D libwebrtc_apm.so
```


如果你要开发 Android 版：
> --no-history 和 --shallow: 大幅减小下载体积（只拉取最新 commit），能有效降低因网络波动导致 src 损坏的概率。
```
# gclient config --spec 'solutions = [
  {
    "name": "src",
    "url": "https://webrtc.googlesource.com/src.git",
    "deps_file": "DEPS",
    "managed": False,
    "custom_deps": {},
  },
]
target_os = ["android", "unix"]

# gclient sync --force --no-history --shallow
```
