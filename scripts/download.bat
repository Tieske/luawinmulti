@echo off
REM Will download and unpack LuaWinMake, LuaRocks and Lua tarballs

REM  ***************  CUSTOMIZATION SECTION  *********************

REM relative nameparts with source code
SET LUA51=lua-5.1.5
SET LUA52=lua-5.2.4
SET LUA53=lua-5.3.1

REM Archive suffix to use for all downloads
SET DL_SUFFIX=.tar.gz
REM URL for Lua archives (relative nameparts and archive suffixes will be appended)
SET DL_PREFIX=http://www.lua.org/ftp/

REM LuaWinMake url and top folder name
SET DL_LUAWINMAKE=https://github.com/Tieske/luawinmake/archive/master
SET LUAWINMAKE_TOPFOLDER=luawinmake-master

REM LuaRocks url and top folder name
SET DL_LUAROCKS=https://github.com/keplerproject/luarocks/archive/master
SET LUAROCKS_TOPFOLDER=luarocks-master

REM  ***************  NOTHING TO CUSTOMIZE BELOW  *********************

if [%1]==[--clean] (
echo start cleaning...
  RMDIR /S /Q "%LUA51%"
  RMDIR /S /Q "%LUA52%"
  RMDIR /S /Q "%LUA53%"
  RMDIR /S /Q "lua-5.1"
  RMDIR /S /Q "lua-5.2"
  RMDIR /S /Q "lua-5.3"
  RMDIR /S /Q "luawinmake"
  RMDIR /S /Q "luarocks"
echo done cleaning...
) else (
  if not [%1]==[] (
    echo.
    echo Invalid commandline option; %1
    echo Usage: scripts\download.bat [--clean]
    echo.
    exit /b 1
  )
)

if not exist luawinmake\*.* (
  tools\wget --no-check-certificate --output-document=luawinmake%DL_SUFFIX% %DL_LUAWINMAKE%%DL_SUFFIX%
  tools\7z x -y luawinmake.tar.gz
  tools\7z x -y luawinmake.tar
  rename %LUAWINMAKE_TOPFOLDER% luawinmake
  del pax_global_header
  del luawinmake*.*
) else (
  echo Skipping LuaWinMake download, directory already exists
)

if not exist luarocks\*.* (
  tools\wget --no-check-certificate --output-document=luarocks%DL_SUFFIX% %DL_LUAROCKS%%DL_SUFFIX%
  tools\7z x -y luarocks.tar.gz
  tools\7z x -y luarocks.tar
  rename %LUAROCKS_TOPFOLDER% luarocks
  del pax_global_header
  del luarocks*.*
) else (
  echo Skipping LuaRocks download, directory already exists
)

if not exist lua-5.1\*.* (
  tools\wget --no-check-certificate --output-document=%LUA51%%DL_SUFFIX% %DL_PREFIX%%LUA51%%DL_SUFFIX%
  tools\7z x -y %LUA51%.tar.gz
  tools\7z x -y %LUA51%.tar
  rename %LUA51% lua-5.1
  del pax_global_header
  del %LUA51%*.*
) else (
  echo Skipping Lua 5.1 download, directory already exists
)

if not exist lua-5.3\*.* (
  tools\wget --no-check-certificate --output-document=%LUA52%%DL_SUFFIX% %DL_PREFIX%%LUA52%%DL_SUFFIX%
  tools\7z x -y %LUA52%.tar.gz
  tools\7z x -y %LUA52%.tar
  rename %LUA52% lua-5.2
  del pax_global_header
  del %LUA52%*.*
) else (
  echo Skipping Lua 5.2 download, directory already exists
)

if not exist lua-5.3\*.* (
  tools\wget --no-check-certificate --output-document=%LUA53%%DL_SUFFIX% %DL_PREFIX%%LUA53%%DL_SUFFIX%
  tools\7z x -y %LUA53%.tar.gz
  tools\7z x -y %LUA53%.tar
  rename %LUA53% lua-5.3
  del pax_global_header
  del %LUA53%*.*
) else (
  echo Skipping Lua 5.3 download, directory already exists
)

