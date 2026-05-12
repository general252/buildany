
windows 
```
配置cgo依赖的gcc环境
下载 https://www.msys2.org/
pacman -S mingw-w64-x86_64-toolchain  ### gcc
PATH 添加 D:\app\msys64\mingw64\bin


配置pkg-config
pacman -S mingw-w64-x86_64-pkg-config ### pkg-config
配置 PKG_CONFIG_PATH 变量
D:\app\ffmpeg-master-latest-win64-gpl-shared\lib\pkgconfig

```

linux
```
配置 PKG_CONFIG_PATH 变量
export PKG_CONFIG_PATH=$PWD/ffmpeg-master-latest-linux64-gpl-shared/lib/pkgconfig:$PKG_CONFIG_PATH
go build .
```


修改poc文件, 修改Cflags等
```
prefix=${pcfiledir}/../..
```


验证环境
```
# pkg-config --list-all
# pkg-config --cflags --libs libavcodec

# pkg-config --cflags webrtc-audio-processing-2
-ID:/app/pkg/webrtc-audio-processing/webrtc-audio-processing/dist_win64/include/webrtc-audio-processing-2 -ID:/app/pkg/webrtc-audio-processing/webrtc-audio-processing/dist_win64/include -DWEBRTC_LIBRARY_IMPL -DWEBRTC_WIN -D_WIN32 -D__STDC_FORMAT_MACROS=1 -DNOMINMAX -D_USE_MATH_DEFINES
```


golang 使用pkg-config引用库
```
package apm

/*
#cgo CXXFLAGS: -std=c++17
#cgo LDFLAGS: -lstdc++
#cgo pkg-config: webrtc-audio-processing-2

#include "bridge.h"
*/
import "C"
import (
	"fmt"
	"runtime"
	"unsafe"
)
```