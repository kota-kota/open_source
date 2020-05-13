@echo off

rem Current
set CUR_PATH=%~dp0

rem platform
rem set PLATFORM=x86
set PLATFORM=x64

rem target
set TARGET_PATH=%CUR_PATH%\openssl-1.1.1g

rem output
set OUTPUT_PATH=%CUR_PATH%\windows\%PLATFORM%
set OUTPUT_INC_PATH=%OUTPUT_PATH%\include
set OUTPUT_LIB_PATH=%OUTPUT_PATH%\lib
if not exist %OUTPUT_INC_PATH% (
	mkdir %OUTPUT_INC_PATH%
)
if not exist %OUTPUT_LIB_PATH% (
	mkdir %OUTPUT_LIB_PATH%
)

rem Visual Studio
set VS_DIR=%ProgramFiles(x86)%\Microsoft Visual Studio 14.0
set VC_DIR=%VS_DIR%\VC
set VC_BAT_PATH=%VC_DIR%\vcvarsall.bat


echo [openssl]ビルド開始

rem build start
cd %TARGET_PATH%

rem x86
if %PLATFORM% == x86 (
	echo ---- x86 ----
	call "%VC_BAT_PATH%" x86
	perl Configure --release no-asm no-shared --prefix=%TARGET_PATH%\x86 VC-WIN32
	nmake clean
	nmake
	rem nmake test
	nmake install
)

rem x64
if %PLATFORM% == x64 (
	echo ---- x64 ----
	call "%VC_BAT_PATH%" x86_amd64
	perl Configure --release no-asm no-shared --prefix=%TARGET_PATH%\x64 VC-WIN64A
	nmake clean
	nmake
	rem nmake test
	nmake install
)

if exist %TARGET_PATH%\%PLATFORM%\lib\libssl.lib (
	xcopy /Y %TARGET_PATH%\%PLATFORM%\lib\libssl.lib %OUTPUT_LIB_PATH%
	xcopy /Y %TARGET_PATH%\%PLATFORM%\lib\libcrypto.lib %OUTPUT_LIB_PATH%
)
else (
	xcopy /Y %TARGET_PATH%\%PLATFORM%\lib\ssleay32.lib %OUTPUT_LIB_PATH%
	xcopy /Y %TARGET_PATH%\%PLATFORM%\lib\libeay32.lib %OUTPUT_LIB_PATH%
)
xcopy /Y /S /E %TARGET_PATH%\%PLATFORM%\include\* %OUTPUT_INC_PATH%

echo [openssl]ビルド完了
pause
