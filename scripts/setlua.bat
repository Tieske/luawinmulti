@echo off

IF [%1]==[] goto VersionOK
IF [%1]==[51] goto VersionOK
IF [%1]==[52] goto VersionOK
IF [%1]==[53] goto VersionOK
IF [%1]==[--help] GOTO Help
IF [%1]==[-help] GOTO Help
IF [%1]==[help] GOTO Help
IF [%1]==[--?] GOTO Help
IF [%1]==[-?] GOTO Help
IF [%1]==[?] GOTO Help
IF [%1]==[/?] GOTO Help

echo Error: unknown commandline argument '%1'. Use '%~n0 --help' for usage information.
exit /b 1

:Help
echo Will setup the environment for the Lua installation, system path and Lua paths. If a 
echo Lua version is provided, it will be set as the unversioned default version.
echo.
echo Usage:
echo    %~n0 ^<LuaVersion^>
echo Where the optional LuaVersion is any of; 51, 52, or 53
echo.
exit /b

:VersionOK
SET myownpath=%~dp0
REM Save the original path in case this file is called more than once
if "%BEFORE_LUA_PATH_BACKUP%"=="" (
   set "BEFORE_LUA_PATH_BACKUP=%PATH%"
) else (
   set "PATH=%BEFORE_LUA_PATH_BACKUP%"
)

setlocal ENABLEDELAYEDEXPANSION
IF not [%1]==[] (
  REM verify the version actually exists
  if not exist "%myownpath%lua%1.exe" (
    echo Error: "%myownpath%lua%1.exe" not found, make sure the version is installed before setting it.
    exit /b 1
  )

  REM compare files, so we do not execute any admin-priviledged
  REM commands unnecessary
  fc "%myownpath%lua%1.exe" "%myownpath%lua.exe" > NUL 2>&1
  if [!ERRORLEVEL!]==[0] (
    echo lua%1.exe was already set as default.
  ) else (
    REM they differ, so we must update them

    copy "%myownpath%lua%1.exe" "%myownpath%lua.exe" /B /Y > NUL
    if not [!ERRORLEVEL!]==[0] (
      echo Error: could not set the proper defaults. Do you have the right permissions?
      exit /b 1
    )
    Echo Installed lua%1.exe as lua.exe.
    REM create wrapper to LuaRocks
    ECHO @ECHO OFF                          >  "%~dp0luarocks.bat"
    ECHO SETLOCAL                           >> "%~dp0luarocks.bat"
    ECHO CALL "%%~dpn0%1.bat" %%*           >> "%~dp0luarocks.bat"
    ECHO exit /b %%ERRORLEVEL%%             >> "%~dp0luarocks.bat"
    Echo Installed luarocks%1.bat as luarocks.bat.
  )
)
endlocal

REM setup system path
set path=%appdata%\luarocks\bin;%myownpath%;%PATH%

REM all paths: luarocks user-tree, luarocks system-tree, defaults
REM setup Lua paths for 5.1
set LUA_CPATH=%appdata%\luarocks\lib\lua\5.1\?.dll;%myownpath%..\lib\lua\5.1\?.dll;;
set LUA_PATH=%appdata%\luarocks\share\lua\5.1\?.lua;%appdata%\luarocks\share\lua\5.1\?\init.lua;%myownpath%..\share\lua\5.1\?.lua;%myownpath%..\share\lua\5.1\?\init.lua;;

REM setup Lua paths for 5.2
set LUA_CPATH_5_2=%appdata%\luarocks\lib\lua\5.2\?.dll;%myownpath%..\lib\lua\5.2\?.dll;;
set LUA_PATH_5_2=%appdata%\luarocks\share\lua\5.2\?.lua;%appdata%\luarocks\share\lua\5.2\?\init.lua;%myownpath%..\share\lua\5.2\?.lua;%myownpath%..\share\lua\5.2\?\init.lua;;

REM setup Lua paths for 5.3, defaults will do, but we need to add the user-tree
set LUA_CPATH_5_3=%appdata%\luarocks\lib\lua\5.3\?.dll;;
set LUA_PATH_5_3=%appdata%\luarocks\share\lua\5.3\?.lua;%appdata%\luarocks\share\lua\5.3\?\init.lua;;

echo Paths have been set up for binaries and Lua modules for lua%1.

:cleanup
set myownpath=
exit /b
