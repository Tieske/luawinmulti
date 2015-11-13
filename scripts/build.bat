@echo off
SETLOCAL

if [%1]==[--nocompat] (
  set COMPAT=--NOCOMPAT
) else (
  set COMPAT=
  if not [%1]==[] (
    echo.
    echo Invalid commandline option; %1
    echo Usage: scripts\build.bat [--nocompat]
    echo.
    exit /b 1
  )
)

SET MAKE=luawinmake

REM Build 51
if exist lua-5.1\src\lua51.dll (
  echo Skipping Lua 5.1 build, binaries already exist
) else (
  XCOPY /E/Y "%MAKE%" "lua-5.1"
  CD lua-5.1
  CALL etc\winmake clean
  CALL etc\winmake %COMPAT%
  CD ..
)

REM Build 52
if exist lua-5.2\src\lua52.dll (
  echo Skipping Lua 5.2 build, binaries already exist
) else (
  XCOPY /E/Y "%MAKE%" "lua-5.2"
  CD lua-5.2
  CALL etc\winmake clean
  CALL etc\winmake %COMPAT%
  CD ..
)

REM Build 53
if exist lua-5.3\src\lua53.dll (
  echo Skipping Lua 5.3 build, binaries already exist
) else (
  XCOPY /E/Y "%MAKE%" "lua-5.3"
  CD lua-5.3
  CALL etc\winmake clean
  CALL etc\winmake %COMPAT%
  CD ..
)

