@echo off

rem Current
set CUR_PATH=%~dp0

rem platform
rem set PLATFORM=x86
set PLATFORM=x64

rem nasm
set NASM_PATH=C:\Users\Kyohei\AppData\Local\bin\NASM
set PATH=%PATH%;%NASM_PATH%

rem target
set TARGET_PATH=%CUR_PATH%\libjpeg-turbo-1.5.3

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
set MSBUILD="%ProgramFiles(x86)%\MSBuild\14.0\Bin\MSBuild.exe"


echo [libjpeg]ビルド開始

rem build start
set BUILD_PATH=%TARGET_PATH%\build
if exist %BUILD_PATH% (
	rmdir /s /q %BUILD_PATH%
)
mkdir %BUILD_PATH%
cd %BUILD_PATH%

rem x86
if %PLATFORM% == x86 (
	echo ---- x86 ----
	cmake %TARGET_PATH% -G "Visual Studio 14 2015" -DNASM=nasm.exe
	%MSBUILD% ALL_BUILD.vcxproj /t:Rebuild /p:PlatformToolset=v140 /p:SolutionDir=%BUILD_PATH%;Configuration="Release";Platform="x86"
)

rem x64
if %PLATFORM% == x64 (
	echo ---- x64 ----
	cmake %TARGET_PATH% -G "Visual Studio 14 2015 Win64" -DNASM=nasm.exe
	%MSBUILD% ALL_BUILD.vcxproj /t:Rebuild /p:PlatformToolset=v140 /p:SolutionDir=%BUILD_PATH%;Configuration="Release";Platform="x64"
)

cd %TARGET_PATH%
xcopy /Y .\build\Release\jpeg-static.lib %OUTPUT_LIB_PATH%
xcopy /Y .\build\jconfig.h %OUTPUT_INC_PATH%
xcopy /Y .\jerror.h %OUTPUT_INC_PATH%
xcopy /Y .\jmorecfg.h %OUTPUT_INC_PATH%
xcopy /Y .\jpeglib.h %OUTPUT_INC_PATH%

rem go back currenty
cd %CUR_PATH%


echo [libjpeg]ビルド完了
pause
