@echo off

rem Current
set CUR_PATH=%~dp0

rem platform
rem set PLATFORM=x86
set PLATFORM=x64

rem target
set TARGET_PATH=%CUR_PATH%\glew-2.1.0

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
set MSBUILD="%ProgramFiles(x86)%\MSBuild\14.0\Bin\MSBuild.exe"


echo [GLEW] Windowsビルド開始

rem build start
set BUILD_PATH=%TARGET_PATH%\build\cmake\build
if exist %BUILD_PATH% (
	rmdir /s /q %BUILD_PATH%
)
mkdir %BUILD_PATH%
cd %BUILD_PATH%

rem x86
if %PLATFORM% == x86 (
	echo ---- x86 ----
	cmake %TARGET_PATH%\build\cmake -G "Visual Studio 14 2015"
	%MSBUILD% ALL_BUILD.vcxproj /t:Rebuild /p:PlatformToolset=v140 /p:SolutionDir=%BUILD_PATH%;Configuration="Release";Platform="x86"
)

rem x64
if %PLATFORM% == x64 (
	echo ---- x64 ----
	cmake %TARGET_PATH%\build\cmake -G "Visual Studio 14 2015 Win64"
	%MSBUILD% ALL_BUILD.vcxproj /t:Rebuild /p:PlatformToolset=v140 /p:SolutionDir=%BUILD_PATH%;Configuration="Release";Platform="x64"
)

xcopy /Y %TARGET_PATH%\build\cmake\build\bin\Release\glew32.dll %OUTPUT_LIB_PATH%
xcopy /Y %TARGET_PATH%\build\cmake\build\lib\Release\glew32.lib %OUTPUT_LIB_PATH%
xcopy /Y %TARGET_PATH%\build\cmake\build\lib\Release\libglew32.lib %OUTPUT_LIB_PATH%
xcopy /Y /S /E %TARGET_PATH%\include\* %OUTPUT_INC_PATH%

echo [GLEW] Windowsビルド完了
pause
