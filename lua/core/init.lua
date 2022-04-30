local M = {}

---@return MiNV
function M.preset()
  ---@class MiNV
  local preset = {
    builtin = require("builtin").preset(),
    autocmds = require("core.autocmds").preset(),
    settings = require("core.settings").preset(),
    keybindings = require("core.keybindings").preset(),
  }
  return preset
end

function M.setup()
  -- Speed up startup time.
  pcall(require, "impatient")

  -- Load presets.
  local minv = M.preset()

  M._plugins = {
    -- Packer
    { "wbthomason/packer.nvim" },
    -- Speed up startup time.
    { "lewis6991/impatient.nvim" },
  }
  local plugins = M._plugins

  -- Load customization.
  local ok_custom, custom = pcall(require, "custom")
  if ok_custom then
    vim.list_extend(plugins, custom.setup(minv))
  end

  -- Builtin plugins.
  vim.list_extend(plugins, require("builtin").setup(minv))

  require("core.settings").setup(minv)
  require("core.autocmds").setup(minv)
  require("core.plugins").setup(minv, plugins)
  require("core.keybindings").setup(minv)
end

return M
