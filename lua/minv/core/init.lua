local M = {}

---@return MiNV
function M.preset()
  ---@class MiNV
  local preset = {
    plugins = require("minv.core.plugins").preset(),
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
  _G._MINV = M.preset()

  -- Load customization.
  local ok, msg = pcall(custom, _MINV)
  if not ok then
    vim.notify(msg, vim.log.levels.ERROR)
  end

  require("minv.core.settings").setup(_MINV)
  require("minv.core.autocmds").setup(_MINV)
  require("minv.core.plugins").setup(_MINV)
  require("minv.core.keybindings").setup(_MINV)
end

return M
