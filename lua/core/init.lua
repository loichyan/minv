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
  for _, map in pairs(minv.keymaps) do
    utils.map(map[1], map[2], map[3], map[4])
  end
  -- Auto commands.
  for _, au in pairs(minv.au) do
    utils.au(au[1], au[2], au[3])
  end
end

return M
