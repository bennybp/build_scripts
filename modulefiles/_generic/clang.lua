help([[ ]])

local pn = myModuleName()
local fn = myFileName()
local full = myModuleFullName()

local loc = fn:find(full,1,true)-2
local pkg = fn:gsub("modulefiles/(.*).lua", "software/%1")

-- mostly for intel python
conflict("intel-" .. pn)

local bindir = pathJoin(pkg, "bin")
local bin64dir = pathJoin(pkg, "bin64")
local libdir = pathJoin(pkg, "lib")
local lib64dir = pathJoin(pkg, "lib64")
local includedir = pathJoin(pkg, "include")
local mandir = pathJoin(pkg, "share", "man")
local infodir = pathJoin(pkg, "share", "info")

if (isDir(bindir)) then prepend_path("PATH", bindir) end
if (isDir(bin64dir)) then prepend_path("PATH", bin64dir) end
if (isDir(libdir)) then prepend_path("LD_LIBRARY_PATH", libdir) end
if (isDir(libdir)) then prepend_path("LIBRARY_PATH", libdir) end
if (isDir(lib64dir)) then prepend_path("LD_LIBRARY_PATH", lib64dir) end
if (isDir(lib64dir)) then prepend_path("LIBRARY_PATH", lib64dir) end
if (isDir(includedir)) then prepend_path("CPATH", includedir) end
if (isDir(mandir)) then prepend_path("MANPATH", mandir) end
if (isDir(infodir)) then prepend_path("INFOPATH", infodir) end

local comp = fn:gsub("modulefiles/Core/(.*).lua", "modulefiles/Compiler/%1")
prepend_path("MODULEPATH", comp)
