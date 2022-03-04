local M = {}

local function minv()
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
  _MINV = minv()

  -- Load custom settings.
  local ok_custom, custom = pcall(require, "custom")
  if ok_custom then
    custom.setup(_MINV)
  end

  -- Plugins.
  require("core.plugins").setup(_MINV.builtin, _MINV.extra)
  -- Settings.
  require("core.settings").setup(_MINV.settings)
  -- Keymaps.
  require("core.keymaps").setup(_MINV.keymaps)
  -- Auto commands.
  require("core.autocmds").setup(_MINV.autocmds)
end

return M
