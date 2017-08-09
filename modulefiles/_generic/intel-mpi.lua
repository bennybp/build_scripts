help([[ ]])

local pn = myModuleName()
local v = myModuleVersion()
local pv = pn .. "-" .. v
local base_dir = pathJoin("/opt/intel", v, "compilers_and_libraries/linux/mpi")

whatis("Version: " .. v)
whatis("Keywords: MPI")
setenv("I_MPI_ROOT", base_dir)
prepend_path("PATH", pathJoin(base_dir, "intel64/bin"))
prepend_path("CLASSPATH", pathJoin(base_dir, "intel64/lib/mpi.jar"))
prepend_path("LD_LIBRARY_PATH", pathJoin(base_dir, "mic/lib"))
prepend_path("LD_LIBRARY_PATH", pathJoin(base_dir, "intel64/lib"))
prepend_path("MANPATH", pathJoin(base_dir, "man"))
