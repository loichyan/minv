local M = {}

---@param custom fun(minv:MiNV):any[]
function M.setup(custom)
  require("minv.core").setup(custom)
end

return M
