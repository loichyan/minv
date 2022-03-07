local M = {}

function M.preset()
  ---@class MiNV
  local preset = {
    builtin = require("builtin").preset(),
    autocmds = require("core.autocmds").preset(),
    settings = require("core.settings").preset(),
    keybindings = require("core.keybindings").preset(),
    -- TODO: add hooks
  }
  return preset
end

function M.setup()
  -- Speed up startup time.
  pcall(require, "impatient")

  -- Load presets.
  local minv = M.preset()

  -- Load customization.
  local extra = {}
  local ok_custom, custom = pcall(require, "custom")
  if ok_custom then
    extra = custom.setup(minv)
  end

  -- Plugins.
  require("core.plugins").setup(minv, extra)
  -- Settings.
  require("core.settings").setup(minv)
  -- Keybindings.
  require("core.keybindings").setup(minv)
  -- Auto commands.
  require("core.autocmds").setup(minv)
end

return M
