@echo off

rem Current
set CUR_PATH=%~dp0

rem platform
rem set PLATFORM=x86
set PLATFORM=x64

rem target
set TARGET_PATH=%CUR_PATH%\libxml2-2.9.10

rem zlib
set ZLIB_PATH=%CUR_PATH%\..\zlib\zlib-1.2.11

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


echo [libxml2]ビルド開始

rem build start
cd %TARGET_PATH%\win32

rem edit configure.js
perl -i.bak -p -e "s/configure.in/configure.ac/g;" configure.js

rem x86
if %PLATFORM% == x86 (
	echo ---- x86 ----
	call "%VC_BAT_PATH%" x86
	cscript configure.js compiler=msvc iconv=no zlib=yes debug=no prefix=.\x86 include=%ZLIB_PATH% lib=%ZLIB_PATH%
	nmake -f Makefile.msvc clean
	nmake -f Makefile.msvc
	nmake -f Makefile.msvc install

	rem copy
	xcopy /Y .\x86\bin\libxml2.dll %OUTPUT_LIB_PATH%
	xcopy /Y .\x86\lib\libxml2.lib %OUTPUT_LIB_PATH%
	xcopy /Y /S /E .\x86\include\libxml2\* %OUTPUT_INC_PATH%
)

rem x64
if %PLATFORM% == x64 (
	echo ---- x64 ----
	call "%VC_BAT_PATH%" x86_amd64
	cscript configure.js compiler=msvc iconv=no zlib=yes debug=no prefix=.\x64 include=%ZLIB_PATH% lib=%ZLIB_PATH%
	nmake -f Makefile.msvc clean
	nmake -f Makefile.msvc
	nmake -f Makefile.msvc install

	rem copy
	xcopy /Y .\x64\bin\libxml2.dll %OUTPUT_LIB_PATH%
	xcopy /Y .\x64\lib\libxml2.lib %OUTPUT_LIB_PATH%
	xcopy /Y /S /E .\x64\include\libxml2\* %OUTPUT_INC_PATH%
)

rem go back currenty
cd %CUR_PATH%

echo [libxml2]ビルド完了
pause
