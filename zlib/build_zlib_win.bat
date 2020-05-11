@echo off

rem Current
set CUR_PATH=%~dp0

rem platform
rem set PLATFORM=x86
set PLATFORM=x64

rem target
set TARGET_PATH=%CUR_PATH%\zlib-1.2.11

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


echo [zlib]ビルド開始

rem build start
cd %TARGET_PATH%

rem x86
if %PLATFORM% == x86 (
	echo ---- x86 ----
	call "%VC_BAT_PATH%" x86
	nmake -f .\win32\Makefile.msc clean
	nmake -f .\win32\Makefile.msc LOC="-DASMV -DASMINF" OBJA="match686.obj inffas32.obj"
)

rem x64
if %PLATFORM% == x64 (
	echo ---- x64 ----
	call "%VC_BAT_PATH%" x86_amd64
	nmake -f .\win32\Makefile.msc clean
	nmake -f .\win32\Makefile.msc AS=ml64 LOC="-DASMV -DASMINF -I." OBJA="inffasx64.obj gvmat64.obj inffas8664.obj"
)

rem go back currenty
cd %CUR_PATH%

rem copy
xcopy /Y %TARGET_PATH%\zlib1.dll %OUTPUT_LIB_PATH%
xcopy /Y %TARGET_PATH%\zdll.lib %OUTPUT_LIB_PATH%
xcopy /Y %TARGET_PATH%\zconf.h %OUTPUT_INC_PATH%
xcopy /Y %TARGET_PATH%\zlib.h %OUTPUT_INC_PATH%

echo [zlib]ビルド完了
pause
