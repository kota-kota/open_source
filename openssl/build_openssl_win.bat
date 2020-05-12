@echo off

rem Current
set CUR_PATH=%~dp0

rem platform
rem set PLATFORM=x86
set PLATFORM=x64

rem target
set TARGET_PATH=%CUR_PATH%\openssl-1.1.1g

rem output
set OUTPUT_PATH=%CUR_PATH%\windows
set OUTPUT_INC_PATH=%OUTPUT_PATH%\include
set OUTPUT_LIB_PATH=%OUTPUT_PATH%\lib\%PLATFORM%
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
	nmake test
	nmake install

	rem copy
	xcopy /Y .\x86\lib\libeay32.lib %OUTPUT_LIB_PATH%
	xcopy /Y .\x86\lib\ssleay32.lib %OUTPUT_LIB_PATH%
	xcopy /Y .\x86\lib\libcrypto.lib %OUTPUT_LIB_PATH%
	xcopy /Y .\x86\lib\libssl.lib %OUTPUT_LIB_PATH%
	copy /Y .\x86\lib\libcrypto.lib %OUTPUT_LIB_PATH%\libeay32.lib
	copy /Y .\x86\lib\libssl.lib %OUTPUT_LIB_PATH%\ssleay32.lib
	if not exist %OUTPUT_INC_PATH%\x86\openssl (
		mkdir %OUTPUT_INC_PATH%\x86\openssl
	)
	xcopy /Y /S /E .\x86\include\openssl\* %OUTPUT_INC_PATH%\x86\openssl
)

rem x64
if %PLATFORM% == x64 (
	echo ---- x64 ----
	call "%VC_BAT_PATH%" x86_amd64
	perl Configure --release no-asm no-shared --prefix=%TARGET_PATH%\x64 VC-WIN64A
	nmake
	nmake test
	nmake install

	rem copy
	xcopy /Y .\x64\lib\libeay32.lib %OUTPUT_LIB_PATH%
	xcopy /Y .\x64\lib\ssleay32.lib %OUTPUT_LIB_PATH%
	xcopy /Y .\x64\lib\libcrypto.lib %OUTPUT_LIB_PATH%
	xcopy /Y .\x64\lib\libssl.lib %OUTPUT_LIB_PATH%
	copy /Y .\x64\lib\libcrypto.lib %OUTPUT_LIB_PATH%\libeay32.lib
	copy /Y .\x64\lib\libssl.lib %OUTPUT_LIB_PATH%\ssleay32.lib
	if not exist %OUTPUT_INC_PATH%\x64\openssl (
		mkdir %OUTPUT_INC_PATH%\x64\openssl
	)
	xcopy /Y /S /E .\x64\include\openssl\* %OUTPUT_INC_PATH%\x64\openssl
)

rem go back currenty
cd %CUR_PATH%

echo [openssl]ビルド完了
pause
