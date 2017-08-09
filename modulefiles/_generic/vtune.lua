help([[ ]])

local pn = myModuleName()
local v = myModuleVersion()
local pv = pn .. "-" .. v
local base_dir = pathJoin("/opt/intel", v, "vtune_amplifier_xe")

prepend_path("PATH", pathJoin(base_dir, "/bin64"))
setenv("VTUNE_AMPLIFIER_XE_2017_DIR", base_dir)
