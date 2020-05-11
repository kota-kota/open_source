# open_source

オープンソースソフトウェアのビルドツールを提供する。

## 準備

以下のツールが必要なので、事前にインストールしておくこと。

__Visual Studio__  
nmake,MSBuildコマンドを使用するため。

__ActivePerl__  
コマンドプロンプトからperlコマンドを使用するため。

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
Ver. 2.9

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
    set TARGET_PATH=%CUR_PATH%\freetype-2.9
    ```

- 生成物が、`freetype/windows`以下に出力される。

### freetypeビルド（Android）

- `jni/Android.mk`の`FREETYPE_SRC_PATH`を、展開したフォルダの名前に修正する。

    ```makefile
    FREETYPE_SRC_PATH := ../freetype-2.9/
    ```

- `freetype/`フォルダ配下の`build_freetype_android.bat`を実行する。

    ビルドターゲットは以下を修正する。

    ```batch
    rem target
    set TARGET_PATH=%CUR_PATH%\freetype-2.9
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
    set ZLIB_PATH=%CUR_PATH%\..\zlib\zlib-1.2.11
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

## 補足

- [Androidビルド]`jni/Application.mk`の`APP_ABI`で、ビルドターゲットを変更できる。

    ```makefile
    APP_ABI := armeabi-v7a arm64-v8a x86 x86_64
    ```
