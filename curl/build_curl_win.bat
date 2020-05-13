@echo off

rem Current
set CUR_PATH=%~dp0

rem platform
rem set PLATFORM=x86
set PLATFORM=x64

rem target
set TARGET_PATH=%CUR_PATH%\curl-7.70.0

rem zlib
set ZLIB_PATH=%CUR_PATH%\..\zlib\windows\%PLATFORM%

rem OpenSSL
set SSL_PATH=%CUR_PATH%\..\openssl\windows\%PLATFORM%

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


echo [curl] Windowsビルド開始

rem build start
cd %TARGET_PATH%\winbuild

rem x86
if %PLATFORM% == x86 (
	echo ---- x86 ----
	call "%VC_BAT_PATH%" x86
	nmake /f Makefile.vc mode=static clean
	nmake /f Makefile.vc mode=static VC=14 WITH_SSL=static SSL_PATH=%SSL_PATH% WITH_ZLIB=static ZLIB_PATH=%ZLIB_PATH% MACHINE=x86
)

rem x64
if %PLATFORM% == x64 (
	echo ---- x64 ----
	call "%VC_BAT_PATH%" x86_amd64
	nmake /f Makefile.vc mode=static clean
	nmake /f Makefile.vc mode=static VC=14 WITH_SSL=static SSL_PATH=%SSL_PATH% WITH_ZLIB=static ZLIB_PATH=%ZLIB_PATH% MACHINE=x64
)

rem copy
cd %TARGET_PATH%\builds\libcurl-vc14-%PLATFORM%-release-static-ssl-static-zlib-static-ipv6-sspi
xcopy /Y .\lib\libcurl_a.lib %OUTPUT_LIB_PATH%
xcopy /Y /S /E .\include\* %OUTPUT_INC_PATH%

echo [curl] Windowsビルド完了
pause
