Multi-lua for Windows script
============================

This batchfile will download, compile and configure a Lua installation with 
versions 5.1, 5.2, and 5.3 in parallel. Including the accompanying 
LuaRocks package manager for each version.

Instructions
============

1. Download an unpack in a temporary directory
2. Customize the target locations (Lua and LuaRocks) in `make.bat`
3. Run `make.bat` (if target locations require it, use Admin rights)

Note: Make sure you have a compiler in your path (MinGW or for the MS compilers, 
call `make.bat` from the commandshell)


What it does
============

- Downloads and unpacks sources of LuaRocks, LuaWinmake (used for building), and Lua
- Compiles the Lua versions from source (using [LuaWinMake](https://github.com/Tieske/luawinmake)
- Installs the Lua versions (versioned; using the LuaWinMake command `installv`)
- Installs LuaRocks for each version
- default Lua version will be set to Lua 5.1 (see `setlua` below)


Usage
=====

Each Lua version will have its own executable; lua51.exe, lua52.exe and 
lua53.exe. And for LuaRocks 3 batchfiles will be generated; luarocks51.bat,
luarocks52.bat, and luarocks53.bat

The luarocks batch files will be in the same directory as the lua executables, so
only the Lua path has to be added to the system path.

The utility `setlua.bat` will setup default versions for Lua and LuaRocks unversioned
commands. eg. `setlua 53` will create a copy of `lua53.exe` as `lua.exe`, and will 
create a batch file `luarocks.bat` that will invoke `luarocks53.bat`.
Besides that it will add the Lua location to the system path and install all LuaRocks
system rocktrees into the respective Lua path environment variables.

Calling `setlua.bat` without a parameter will only set the paths and not change the 
unversioned `lua` and `luarocks` commands. This can be used as a Lua commandshell 
specific for this environment. For example; create a shortcut with target
`C:\Windows\System32\cmd.exe /k c:\lua\bin\setlua.bat` (assuming the default Lua 
location `c:\lua`).

License
=======
Copyright 2015 - Thijs Schreijer.
MIT license for this project. Please note that other components are included
which are covered by different licenses. See COPYING file for details.
