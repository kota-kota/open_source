@echo off

rem Current
set CUR_PATH=%~dp0

rem target
set TARGET_PATH=%CUR_PATH%\lpng1637

rem output
set OUTPUT_PATH=%CUR_PATH%\android
set OUTPUT_INC_PATH=%OUTPUT_PATH%\include
set OUTPUT_LIB_PATH=%OUTPUT_PATH%\lib
if not exist %OUTPUT_INC_PATH% (
mkdir %OUTPUT_INC_PATH%
)
if not exist %OUTPUT_LIB_PATH% (
mkdir %OUTPUT_LIB_PATH%
)

echo [libpng]ビルド開始

rem build start
cd jni
call ndk-build

rem go back currenty
cd %CUR_PATH%


rem copy
call :copy_lib arm64-v8a
rem call :copy_lib armeabi-v7a
rem call :copy_lib x86
call :copy_lib x86_64
xcopy /Y %TARGET_PATH%\png.h %OUTPUT_INC_PATH%
xcopy /Y %TARGET_PATH%\pngconf.h %OUTPUT_INC_PATH%
xcopy /Y %TARGET_PATH%\pnglibconf.h %OUTPUT_INC_PATH%
xcopy /Y %TARGET_PATH%\pngstruct.h %OUTPUT_INC_PATH%


echo [libpng]ビルド完了
pause
exit /b



:copy_lib
set PLATFORM=%1
if not exist %OUTPUT_LIB_PATH%\%PLATFORM% (
	mkdir %OUTPUT_LIB_PATH%\%PLATFORM%
)
xcopy /Y obj\local\%PLATFORM%\*.a %OUTPUT_LIB_PATH%\%PLATFORM%
exit /b
