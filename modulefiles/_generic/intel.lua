help([[ ]])

local pn = myModuleName()
local v = myModuleVersion()
local pv = pn .. "-" .. v
local base_dir = pathJoin("/opt/intel", v, "compilers_and_libraries", "linux")

prepend_path("PATH", pathJoin(base_dir, "bin/intel64"))
prepend_path("LIBRARY_PATH", pathJoin(base_dir, "lib/intel64"))
prepend_path("LD_LIBRARY_PATH", pathJoin(base_dir, "lib/intel64"))
prepend_path("MANPATH", pathJoin(base_dir, "man/common"))
append_path("INTEL_LICENSE_FILE", "opt/intel/licenses")
prepend_path("NLSPATH", pathJoin(base_dir, "compiler/lib/intel64/locale/%l_%t/%N"))

setenv("MKLROOT", pathJoin(base_dir, "mkl"))
prepend_path("LIBRARY_PATH", pathJoin(base_dir, "mkl/lib/intel64"))
prepend_path("LD_LIBRARY_PATH", pathJoin(base_dir, "mkl/lib/intel64"))
prepend_path("CPATH", pathJoin(base_dir, "mkl/include"))
prepend_path("NLSPATH", pathJoin(base_dir, "mkl/lib/intel64/locale/%l_%t/%N"))
