@echo off

rem Current
set CUR_PATH=%~dp0

rem target
set TARGET_PATH=%CUR_PATH%\freetype-2.9

rem output
set OUTPUT_PATH=%CUR_PATH%\android

echo [freetype] Android�r���h�J�n

rem build start
cd jni
call ndk-build

rem copy
rem call :copy_lib armeabi-v7a
call :copy_lib arm64-v8a
rem call :copy_lib x86
call :copy_lib x86_64

rem remove
rmdir /s /q %CUR_PATH%\obj

echo [freetype] Android�r���h����
pause
exit /b



:copy_lib
set PLATFORM=%1
set OUTPUT_INC_PATH=%OUTPUT_PATH%\%PLATFORM%\include
set OUTPUT_LIB_PATH=%OUTPUT_PATH%\%PLATFORM%\lib
if not exist %OUTPUT_INC_PATH% (
	mkdir %OUTPUT_INC_PATH%
)
if not exist %OUTPUT_LIB_PATH% (
	mkdir %OUTPUT_LIB_PATH%
)
xcopy /Y %CUR_PATH%\obj\local\%PLATFORM%\libfreetype.a %OUTPUT_LIB_PATH%
xcopy /Y /S /E %TARGET_PATH%\include\* %OUTPUT_INC_PATH%
exit /b
