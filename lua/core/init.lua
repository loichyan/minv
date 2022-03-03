local M = {}

---@param minv MiNV
function M.setup(minv)
  local packer = require("core.packer").setup(minv.builtin.packer)
  -- Plugins.
  require("core.plugins").setup(packer, minv.builtin, minv.extra)
  -- Settings.
  require("preset.settings").setup(minv.settings)
  -- Keymaps.
  require("preset.keymaps").setup(minv.keymaps)
  -- Auto commands.
  require("preset.autocmds").setup(minv.autocmds)
end

return M
