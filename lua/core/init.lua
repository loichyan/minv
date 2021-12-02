local M = {}

---@param minv MiNV
function M.setup(minv)
  local utils = require("utils")
  -- Plugins.
  require("core.plugins").setup(minv.builtin, minv.extra)
  -- Globals.
  utils.g(minv.g)
  -- Options.
  utils.o(minv.o)
  -- Keymaps.
  require("core.keymaps").setup(minv.keymaps)
  -- Auto commands.
  require("core.autocmds").setup(minv.autocmds)
end

return M
