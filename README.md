# open_source

オープンソースソフトウェアのビルドツールを提供する。

## 準備

以下のツールが必要なので、事前にインストールしておくこと。

__Visual Studio__
nmake,MSBuildコマンドを使用するため。

__ActivePerl__
コマンドラインからperlコマンドを使用するため。

__nasm__
Intel記法のx86アセンプラ。コマンドラインから使用するため。

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

    ビルドプラットフォームとビルドターゲットは以下を修正する。

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

### 共通

- <https://sourceforge.net/projects/libpng/files/> からソースをダウンロードする。

- `libpng/`フォルダ配下に展開する。

### Windowsビルド

- 事前に、`zlib`をWindowsビルドしておく。

- `projects/vstudio/vstudio.sln`を開き、x64ビルドを有効にする。

    - ソリューションを選択し「プロパティ」→「構成プロパティ」→「構成マネージャー」

    - アクティブソリューションプラットフォームのプルダウンから「新規作成」

    - 新しいプラットフォームでx64を選択し「OK」

- `libpng/`フォルダ配下の`build_libpng_win.bat`を実行する。
    ビルドプラットフォームとビルドターゲットは以下を修正する。

    ```batch
    rem platform
    rem set PLATFORM=x86
    set PLATFORM=x64

    rem target
    set TARGET_PATH=%CUR_PATH%\lpng1637
    ```

- 生成物が、`libpng/windows`以下に出力される。

### Androidビルド

- `jni/Android.mk`の`LIBPNG_SRC_PATH`を、展開したフォルダの名前に修正する。

    ```makefile
    LIBPNG_SRC_PATH := ../lpng1637/
    ```

- `libpng/`フォルダ配下の`build_libpng_android.bat`を実行する。

    ビルドプラットフォームとビルドターゲットは以下を修正する。

    ```batch
    rem target
    set TARGET_PATH=%CUR_PATH%\lpng1637
    ```

- 生成物が、`libpng/android`以下に出力される。

（補足）`jni/Application.mk`の`APP_ABI`で、ビルドターゲットを変更できる。

```makefile
APP_ABI := armeabi-v7a arm64-v8a x86 x86_64
```
