@echo off

rem Current
set CUR_PATH=%~dp0

rem platform
rem set PLATFORM=x86
set PLATFORM=x64

rem target
set TARGET_PATH=%CUR_PATH%\lpng1637

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


echo [libpng]ビルド開始

rem build start
set SLN_DIR=%TARGET_PATH%\projects\vstudio\
cd %SLN_DIR%

rem edit zlib.props
perl -i.bak -p -e "s/>..\\..\\..\\..\\zlib</>..\\..\\..\\..\\..\\zlib\\zlib-1.2.11</g;" zlib.props

rem x86
if %PLATFORM% == x86 (
echo ---- x86 ----
	%MSBUILD% pnglibconf\pnglibconf.vcxproj /t:Rebuild /p:PlatformToolset=v140 /p:SolutionDir=%SLN_DIR%;Configuration="Release";Platform="x86"
	%MSBUILD% libpng\libpng.vcxproj /t:Rebuild /p:PlatformToolset=v140 /p:SolutionDir=%SLN_DIR%;Configuration="Release Library";Platform="x86"

	rem copy
	cd %TARGET_PATH%
	xcopy /Y .\projects\vstudio\"Release Library"\*.lib %OUTPUT_LIB_PATH%
	xcopy /Y /S /E .\png.h %OUTPUT_INC_PATH%
	xcopy /Y /S /E .\pngconf.h %OUTPUT_INC_PATH%
	xcopy /Y /S /E .\pnglibconf.h %OUTPUT_INC_PATH%
	xcopy /Y /S /E .\pngstruct.h %OUTPUT_INC_PATH%
)

rem x64
if %PLATFORM% == x64 (
	echo ---- x64 ----
	%MSBUILD% pnglibconf\pnglibconf.vcxproj /t:Rebuild /p:PlatformToolset=v140 /p:SolutionDir=%SLN_DIR%;Configuration="Release";Platform="x64"
	%MSBUILD% libpng\libpng.vcxproj /t:Rebuild /p:PlatformToolset=v140 /p:SolutionDir=%SLN_DIR%;Configuration="Release Library";Platform="x64"

	rem copy
	cd %TARGET_PATH%
	xcopy /Y .\projects\vstudio\x64\"Release Library"\libpng16.lib %OUTPUT_LIB_PATH%
	xcopy /Y .\png.h %OUTPUT_INC_PATH%
	xcopy /Y .\pngconf.h %OUTPUT_INC_PATH%
	xcopy /Y .\pnglibconf.h %OUTPUT_INC_PATH%
	xcopy /Y .\pngstruct.h %OUTPUT_INC_PATH%
)

rem go back currenty
cd %CUR_PATH%


echo [libpng]ビルド完了
pause
