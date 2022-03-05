local M = {}

function M.preset()
  ---@class MiNV
  local preset = {
    ---Builtin plugins.
    builtin = require("builtin").preset(),
    ---Extra plugins.
    extra = {},
    ---Vim settings.
    settings = require("core.settings").preset(),
    ---Auto commands.
    autocmds = require("core.autocmds").preset(),
    ---Keymaps.
    keymaps = require("core.keymaps").preset(),
  }
  return preset
end

function M.setup()
  -- Speed up startup time.
  local ok_impatient, impatient = pcall(require, "impatient")
  if ok_impatient then
    impatient.enable_profile()
  end

  -- Load presets.
  local minv = M.preset()

  -- Load customization.
  local ok_custom, custom = pcall(require, "custom")
  if ok_custom then
    custom.setup(minv)
  end

  -- Plugins.
  require("core.plugins").setup(minv)
  -- Settings.
  require("core.settings").setup(minv.settings)
  -- Keymaps.
  require("core.keymaps").setup(minv.keymaps)
  -- Auto commands.
  require("core.autocmds").setup(minv.autocmds)
end

return M
