@echo off

rem Current
set CUR_PATH=%~dp0

rem platform
rem set PLATFORM=x86
set PLATFORM=x64

rem target
set TARGET_PATH=%CUR_PATH%\freetype-2.9

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


echo [freetype]ビルド開始

rem build start
cd %TARGET_PATH%
cd .\builds\windows\vc2010

rem x86
if %PLATFORM% == x86 (
	echo ---- x86 ----
	%MSBUILD% freetype.vcxproj /t:Rebuild /p:PlatformToolset=v140 /p:SolutionDir=.\;Configuration="Release Static";Platform="x86"

	rem copy
	cd %TARGET_PATH%
	xcopy /Y ".\objs\Win32\Release Static\*.lib" %OUTPUT_LIB_PATH%
	xcopy /Y /S /E .\include\* %OUTPUT_INC_PATH%
)

rem x64
if %PLATFORM% == x64 (
	echo ---- x64 ----
	%MSBUILD% freetype.vcxproj /t:Rebuild /p:PlatformToolset=v140 /p:SolutionDir=.\;Configuration="Release Static";Platform="x64"

	rem copy
	cd %TARGET_PATH%
	xcopy /Y ".\objs\x64\Release Static\*.lib" %OUTPUT_LIB_PATH%
	xcopy /Y /S /E .\include\* %OUTPUT_INC_PATH%
)

rem go back currenty
cd %CUR_PATH%


echo [freetype]ビルド完了
pause
