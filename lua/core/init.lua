local M = {}

---@param minv MiNV
function M.setup(minv)
  require("core.plugins").setup(minv.builtin, minv.extra)
  local utils = require("utils")
  utils.g(minv.g)
  utils.o(minv.o)
  utils.keymaps(minv.keymaps)
  utils.autocmds(minv.au)
end

return M
