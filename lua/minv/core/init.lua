local M = {}

---@return MiNV
function M.preset()
  ---@class MiNV
  local preset = {
    builtin = require("minv.builtin").preset(),
    autocmds = require("minv.core.autocmds").preset(),
    settings = require("minv.core.settings").preset(),
    keybindings = require("minv.core.keybindings").preset(),
  }
  return preset
end

---@param custom fun(minv:MiNV):any[]
function M.setup(custom)
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
  vim.list_extend(plugins, custom(minv))

  -- Builtin plugins.
  vim.list_extend(plugins, require("minv.builtin").setup(minv))

  require("minv.core.settings").setup(minv)
  require("minv.core.autocmds").setup(minv)
  require("minv.core.plugins").setup(minv, plugins)
  require("minv.core.keybindings").setup(minv)
end

return M
