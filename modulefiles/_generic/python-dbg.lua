help([[ ]])

-- The version of Valgrind we built this python against
local valgrind_ver="3.13.0"
prereq("valgrind/" .. valgrind_ver)

local pn = myModuleName()
local v = myModuleVersion()
local pv = pn .. "-" .. v
local base_dir = pathJoin("/opt/software",  pn,  pv)

local bindir = pathJoin(base_dir, "bin")
local bin64dir = pathJoin(base_dir, "bin64")
local libdir = pathJoin(base_dir, "lib")
local lib64dir = pathJoin(base_dir, "lib64")
local includedir = pathJoin(base_dir, "include")
local mandir = pathJoin(base_dir, "share", "man")
local infodir = pathJoin(base_dir, "share", "info")

if (isDir(bindir)) then prepend_path("PATH", bindir) end
if (isDir(bin64dir)) then prepend_path("PATH", bin64dir) end
if (isDir(libdir)) then prepend_path("LD_LIBRARY_PATH", libdir) end
if (isDir(lib64dir)) then prepend_path("LD_LIBRARY_PATH", lib64dir) end
if (isDir(includedir)) then prepend_path("CPATH", includedir) end
if (isDir(mandir)) then prepend_path("MANPATH", mandir) end
if (isDir(infodir)) then prepend_path("INFOPATH", infodir) end
