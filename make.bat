@echo off
SETLOCAL

REM WARNING: Target location is forcefully removed! be aware and backup first!

REM ************  CUSTOMIZATION SECTION  *****************

REM __NOTE__: Additional customizations in 'scripts\download.bat'

REM Target locations for Lua and LuaRocks
SET TARGET=C:\Lua
SET LRTARGET=%TARGET%\LuaRocks

SET COMPAT=
REM Uncomment following line to build WITHOUT compatibility options (they are enabled by default)
REM SET COMPAT=--NOCOMPAT


REM ************  NOTHING TO CUSTOMIZE BELOW  *****************



REM Commands which, if exiting without error, indicate presence of the MinGW/gcc toolchain
SET CHECK_GCC=gcc --version

SET MAKE=luawinmake

REM Cleanup first
RMDIR /S /Q "%TARGET%"
RMDIR /S /Q "%LRTARGET%"

REM Download and unpack sources
call scripts\download.bat

REM Check compiler, for the LuaRocks installer commandline switch
Echo Testing for GCC...
%CHECK_GCC%
IF %ERRORLEVEL%==0 (
   SET COMPILER=/MW
   echo Will be installing LuaRocks with MinGW as compiler
) else (
   SET COMPILER=
   echo MinGW not found in system path, assuming MS toolchain for LuaRocks installation
)

REM Build 51
XCOPY /E/Y "%MAKE%" "lua-5.1"
CD lua-5.1
CALL etc\winmake clean
CALL etc\winmake %COMPAT%
CALL etc\winmake installv "%TARGET%"
CD ..\luarocks
CALL install /P "%LRTARGET%" /LV 5.1 /LUA "%TARGET%" /F /NOADMIN /Q /NOREG %COMPILER%
COPY "%LRTARGET%\luarocks.bat" "%TARGET%\bin\luarocks51.bat"
CD ..

REM Build 52
XCOPY /E/Y "%MAKE%" "lua-5.2"
CD lua-5.2
CALL etc\winmake clean
CALL etc\winmake %COMPAT%
CALL etc\winmake installv "%TARGET%"
CD ..\luarocks
CALL install /P "%LRTARGET%" /LV 5.2 /LUA "%TARGET%" /F /NOADMIN /Q /NOREG %COMPILER%
COPY "%LRTARGET%\luarocks.bat" "%TARGET%\bin\luarocks52.bat"
CD ..

REM Build 53
XCOPY /E/Y "%MAKE%" "lua-5.3"
CD lua-5.3
CALL etc\winmake clean
CALL etc\winmake %COMPAT%
CALL etc\winmake installv "%TARGET%"
CD ..\luarocks
CALL install /P "%LRTARGET%" /LV 5.3 /LUA "%TARGET%" /F /NOADMIN /Q /NOREG %COMPILER%
COPY "%LRTARGET%\luarocks.bat" "%TARGET%\bin\luarocks53.bat"
CD ..

REM install setlua.bat utility
copy .\scripts\setlua.bat "%TARGET%\bin"

REM set 5.1 as the default now
call "%TARGET%\bin\setlua.bat" 51

