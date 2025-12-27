Multi-lua for Windows script
============================

This batchfile will download, compile and configure a Lua installation with 
versions 5.1, 5.2, 5.3, 5.4, and 5.5 in parallel. Including the accompanying 
LuaRocks package manager for each version.

Prerequisites
=============
Make sure you have a compiler in your path;

 - MinGW in your system path (msys is not required)
 - for MS compilers, call `make.bat` from the Visual Studio (or Win SDK) commandshell

Known issues
============
Luarocks doesn't work with the Lua 5.5 version. This project ships an older version
of LuaRocks that is not compatible with Lua 5.5.

Command
=======

````
Commandline script to download and install Lua 5.1, 5.2, 5.3, 5.4, and 5.5 with a LuaRocks installation for each.
A 'setlua' script is made available to setup the environment for each version.

Usage:
  MAKE [--clean] [--cleantarget] [--nocompat] [--51] [--52] [--53] [--54] [--55] [--ms|gcc] [install [<location>]]

  --51,--52,--53,--54,--55: specify the versions to install, default is to install
                            all versions. Applies only to installing, all versions will be
                            build independent of this option.
                            The first version listed will be set as the unversioned default.
  --clean            : removes downloaded and build artifacts, forcing a rebuild
  --cleantarget      : removes the target directory before installing. NOTE: the LuaRocks
                       installation will ALWAYS be removed, independent of this option!
  --nocompat         : build Lua without compatibility options. NOTE: this option
                       will not automatically clean. So clean when switching compatibility.
  --ms|gcc           : force usage of either Microsoft (--ms) or gcc (--gcc) toolchain, if
                       not provided it will be auto-detected.
  install <location> : will install (and build if necessary) the Lua versions. Default
                       location is 'C:\Lua'

  --help             : Display this help text

Example: the following commands, executed after each other will;
  make install
                 Will download, build and install 4 Lua versions in 'C:\Lua', 5.1 will
                 be set as the default.

  make --51 --52 install C:\lua2
                 Will only install (no rebuild, binaries allready exist) 5.1 and 5.2 in
                 'C:\Lua2'. 5.1 will be set as the default.

  make --clean --53 --nocompat install C:\Lua_NoCompat
                 Will download and build all versions again, without compatibility options,
                 and then install only 5.3 in 'C:\Lua_NoCompat'. 5.3 will be set as the
                 default.
````



What it does
============

- Downloads and unpacks sources of LuaRocks, LuaWinmake (used for building), and Lua
- Compiles the Lua versions from source (using [LuaWinMake](https://github.com/Tieske/luawinmake))
- Installs the Lua versions (versioned; using the LuaWinMake command `installv`)
- Installs LuaRocks for each version
- default Lua version will be set to Lua 5.1 (see `setlua` below)


Usage
=====

Each Lua version will have its own executable; `lua51.exe`, `lua52.exe`, `lua53.exe`, etc.
And for LuaRocks multiple batchfiles will be generated; `luarocks51.bat`,
`luarocks52.bat`, `luarocks53.bat`, etc.

The luarocks batch files will be in the same directory as the lua executables, so
only the Lua path has to be added to the system path.

The utility `setlua.bat` will setup default versions for Lua and LuaRocks unversioned
commands. eg. `setlua 54` will create a copy of `lua54.exe` as `lua.exe`, and will 
create a batch file `luarocks.bat` that will invoke `luarocks54.bat`.
Besides that it will add the Lua location to the system path and install all LuaRocks
system rocktrees into the respective Lua path environment variables.

Calling `setlua.bat` without a parameter will only set the paths and not change the 
unversioned `lua` and `luarocks` commands. This can be used as a Lua commandshell 
specific for this environment. For example; create a shortcut with target
`C:\Windows\System32\cmd.exe /k c:\lua\bin\setlua.bat` (assuming the default Lua 
location `c:\lua`).

License
=======
Copyright 2015-2025, Thijs Schreijer.
MIT license for this project. Please note that other components are included
which are covered by different licenses. See COPYING file for details.
