# open_source

オープンソースソフトウェアのビルドツールを提供する。

## 準備

以下のツールが必要なので、事前にインストールしておくこと。

__Visual Studio__  
nmake,MSBuildコマンドを使用するため。

__ActivePerl__  
コマンドプロンプトからperlコマンドを使用するため。
OpenSSLではdmakeが必要のため、事前にインストールしておく。

```bash
ppm install dmake
```

__nasm__  
インテルx86を対象としたアセンブラ。libjpegのビルドで使用するため。

__CMake__  
CMakeListsからVisualStudioのソリューションファイルを生成するため。

__ndk-build__  
AndroidNDKビルドに使用するため。  
`${ユーザフォルダ}\AppData\Local\Android\Sdk\ndk-bundle`

## zlib

<https://www.zlib.net/>  
Ver. 1.2.11

### zlibビルド（Windows）

- <https://zlib.net/fossils/> からソースをダウンロードする。

- `zlib/`フォルダ配下に展開する。

- `zlib/`フォルダ配下の`build_zlib_win.bat`を実行する。

    ビルドプラットフォーム,ビルドターゲットは以下を修正する。

    ```batch
    rem platform
    rem set PLATFORM=x86
    set PLATFORM=x64

    rem target
    set TARGET_PATH=%CUR_PATH%\lpng1637
    ```

- 生成物が、`zlib/windows`以下に出力される。

### zlibビルド（Android）

Androidのzlibは、NDKに含まれるため不要。

## libpng

<http://www.libpng.org/pub/png/libpng.html>  
Ver. 1.6.37

### libpngビルド（共通）

- <https://sourceforge.net/projects/libpng/files/> からソースをダウンロードする。

- `libpng/`フォルダ配下に展開する。

### libpngビルド（Windows）

- 事前に、`zlib`をWindowsビルドしておく。

- `projects/vstudio/vstudio.sln`を開き、x64ビルドを有効にする。

  - ソリューションを選択し「プロパティ」→「構成プロパティ」→「構成マネージャー」

  - アクティブソリューションプラットフォームのプルダウンから「新規作成」

  - 新しいプラットフォームでx64を選択し「OK」

- `libpng/`フォルダ配下の`build_libpng_win.bat`を実行する。
    ビルドプラットフォーム,ビルドターゲットは以下を修正する。

    ```batch
    rem platform
    rem set PLATFORM=x86
    set PLATFORM=x64

    rem target
    set TARGET_PATH=%CUR_PATH%\lpng1637
    ```

- 生成物が、`libpng/windows`以下に出力される。

### libpngビルド（Android）

- `jni/Android.mk`の`LIBPNG_SRC_PATH`を、展開したフォルダの名前に修正する。

    ```makefile
    LIBPNG_SRC_PATH := ../lpng1637/
    ```

- `libpng/`フォルダ配下の`build_libpng_android.bat`を実行する。

    ビルドターゲットは以下を修正する。

    ```batch
    rem target
    set TARGET_PATH=%CUR_PATH%\lpng1637
    ```

- 生成物が、`libpng/android`以下に出力される。

## freetype

<https://www.freetype.org/>  
Ver. 2.10.2

※Ver. 2.9 はリンクが通らなかった

### freetypeビルド（共通）

- <https://sourceforge.net/projects/freetype/files/freetype2/> からソースをダウンロードする。

- `freetype/`フォルダ配下に展開する。

### freetypeビルド（Windows）

- `freetype/`フォルダ配下の`build_freetype_win.bat`を実行する。
    ビルドプラットフォーム,ビルドターゲットは以下を修正する。

    ```batch
    rem platform
    rem set PLATFORM=x86
    set PLATFORM=x64

    rem target
    set TARGET_PATH=%CUR_PATH%\freetype-2.10.2
    ```

- 生成物が、`freetype/windows`以下に出力される。

### freetypeビルド（Android）

- `jni/Android.mk`の`FREETYPE_SRC_PATH`を、展開したフォルダの名前に修正する。

    ```makefile
    FREETYPE_SRC_PATH := ../freetype-2.10.2/
    ```

- `freetype/`フォルダ配下の`build_freetype_android.bat`を実行する。

    ビルドターゲットは以下を修正する。

    ```batch
    rem target
    set TARGET_PATH=%CUR_PATH%\freetype-2.10.2
    ```

- 生成物が、`freetype/android`以下に出力される。

## libxml2

<http://xmlsoft.org/>  
Ver. 2.9.10

<https://github.com/aosp-mirror/platform_external_libxml2>
72ac6cf5b8ed69b2c05dcf5ba970b3fcdd4c1c4a

### libxml2ビルド（Windows）

- 事前に、`zlib`をWindowsビルドしておく。

- <http://xmlsoft.org/sources/> からソースをダウンロードする。

- `libxml2/`フォルダ配下に展開する。

- `libxml2/`フォルダ配下の`build_libxml2_win.bat`を実行する。
    ビルドプラットフォーム,ビルドターゲット,zlibのパスは以下を修正する。

    ```batch
    rem platform
    rem set PLATFORM=x86
    set PLATFORM=x64

    rem target
    set TARGET_PATH=%CUR_PATH%\freetype-2.9

    rem zlib
    set ZLIB_PATH=%CUR_PATH%\..\zlib\windows\%PLATFORM%
    ```

- 生成物が、`libxml2/windows`以下に出力される。

### libxml2ビルド（Android）

- <https://github.com/aosp-mirror/platform_external_libxml2> からソースをダウンロードする。

    [Clone or download]->[Download ZIP]を選択する。

- `libxml2/`フォルダ配下に展開する。

- `jni/Android.mk`の`XML_SRC_PATH`を、展開したフォルダの名前に修正する。

    ```makefile
    XML_SRC_PATH := ../platform_external_libxml2-master/
    ```

- `libxml2/`フォルダ配下の`build_libxml2_android.bat`を実行する。

    ビルドターゲットは以下を修正する。

    ```batch
    rem target
    set TARGET_PATH=%CUR_PATH%\platform_external_libxml2-master
    ```

- 生成物が、`libxml2/android`以下に出力される。

## libjpeg

<https://libjpeg-turbo.org/>  
Ver. 1.2.11

### libjpegビルド（Windows）

- <https://sourceforge.net/projects/libjpeg-turbo/files> からソースをダウンロードする。

- `libjpeg/`フォルダ配下に展開する。

- `libjpeg/`フォルダ配下の`build_libjpeg_win.bat`を実行する。

    ビルドプラットフォーム,NASMのパス,ビルドターゲットは以下を修正する。

    ```batch
    rem platform
    rem set PLATFORM=x86
    set PLATFORM=x64

    rem nasm
    set NASM_PATH=C:\Users\Kyohei\AppData\Local\bin\NASM
    set PATH=%PATH%;%NASM_PATH%

    rem target
    set TARGET_PATH=%CUR_PATH%\libjpeg-turbo-1.5.3
    ```

- 生成物が、`libjpeg/windows`以下に出力される。

### libjpegビルド（Android）

未対応

## GLFW

<https://www.glfw.org/>
Ver. 3.3.2

### GLFWビルド（Windows）

- <https://www.glfw.org/> からソースをダウンロードする。

- `glfw/`フォルダ配下に展開する。

- `glfw/`フォルダ配下の`build_glfw_win.bat`を実行する。

    ビルドプラットフォーム,ビルドターゲットは以下を修正する。

    ```batch
    rem platform
    rem set PLATFORM=x86
    set PLATFORM=x64

    rem target
    set TARGET_PATH=%CUR_PATH%\glfw-3.3.2
    ```

- 生成物が、`glfw/windows`以下に出力される。

### GLFWビルド（Android）

Androidでは使用しないため、不要。

## GLEW

<http://glew.sourceforge.net/>
Ver. 2.1.0

### GLEWビルド（Windows）

- <http://glew.sourceforge.net/> からソースをダウンロードする。

- `glew/`フォルダ配下に展開する。

- `glew/`フォルダ配下の`build_glew_win.bat`を実行する。

    ビルドプラットフォーム,ビルドターゲットは以下を修正する。

    ```batch
    rem platform
    rem set PLATFORM=x86
    set PLATFORM=x64

    rem target
    set TARGET_PATH=%CUR_PATH%\glew-2.1.0
    ```

- 生成物が、`glew/windows`以下に出力される。

### GLEWビルド（Android）

Androidでは使用しないため、不要。

## OpenSSL

<https://www.openssl.org/>  
Ver. 1.1.1g

バージョン1.1.0以降、生成物の名前が変わっている。  
libeay32 -> libcrypto  
ssleay32 -> libssl

### OpenSSLビルド（Windows）

- <https://www.openssl.org/> からソースをダウンロードする。

- `openssl/`フォルダ配下に展開する。

- `openssl/`フォルダ配下の`build_openssl_win.bat`を実行する。

    ビルドプラットフォーム,ビルドターゲットは以下を修正する。

    ```batch
    rem platform
    rem set PLATFORM=x86
    set PLATFORM=x64

    rem target
    set TARGET_PATH=%CUR_PATH%\openssl-1.1.1g
    ```

- 生成物が、`openssl/windows`以下に出力される。

### OpenSSLビルド（Android）

未対応

## curl

<https://curl.haxx.se/>  
Ver. 7.70.0

### curlビルド（Windows）

- 事前に、`zlib`と`OpenSSL`をWindowsビルドしておく。

- <https://curl.haxx.se/download.html> からソースをダウンロードする。

- `curl/`フォルダ配下に展開する。

- `curl/`フォルダ配下の`build_curl_win.bat`を実行する。

    ビルドプラットフォーム,ビルドターゲット,zlibパス,OpenSSLパスは以下を修正する。

    ```batch
    rem platform
    rem set PLATFORM=x86
    set PLATFORM=x64

    rem target
    set TARGET_PATH=%CUR_PATH%\curl-7.70.0

    rem zlib
    set ZLIB_PATH=%CUR_PATH%\..\zlib\windows\%PLATFORM%

    rem OpenSSL
    set SSL_PATH=%CUR_PATH%\..\openssl\windows\%PLATFORM%
    ```

- 生成物が、`curl/windows`以下に出力される。

### curlビルド（Android）

未対応

## GoogleTest

<https://github.com/google/googletest>
Ver. 1.10.0

### GoogleTestビルド（Windows）

- <https://github.com/google/googletest/releases> からソースをダウンロードする。

- `googletest/`フォルダ配下に展開する。

- `googletest/`フォルダ配下の`build_googletest_win.bat`を実行する。

    ビルドプラットフォーム,ビルドターゲットは以下を修正する。

    ```batch
    rem platform
    rem set PLATFORM=x86
    set PLATFORM=x64

    rem target
    set TARGET_PATH=%CUR_PATH%\googletest-release-1.10.0
    ```

- 生成物が、`googletest/windows`以下に出力される。

### GoogleTestビルド（Android）

Androidでは使用しないため、不要。

## 補足

- [Androidビルド]`jni/Application.mk`の`APP_ABI`で、ビルドターゲットを変更できる。

    ```makefile
    APP_ABI := armeabi-v7a arm64-v8a x86 x86_64
    ```
