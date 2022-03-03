local M = {}

function M.setup()
  -- Speed up startup time.
  local ok_impatient, impatient = pcall(require, "impatient")
  if ok_impatient then
    impatient.enable_profile()
  end

  -- Load presets.
  _MINV = require("preset").new()

  -- Load custom settings.
  local ok_custom, custom = pcall(require, "custom")
  if ok_custom then
    custom.setup(_MINV)
  end

  local packer = require("core.packer").setup(_MINV.builtin.packer)
  -- Plugins.
  require("core.plugins").setup(packer, _MINV.builtin, _MINV.extra)
  -- Settings.
  require("preset.settings").setup(_MINV.settings)
  -- Keymaps.
  require("preset.keymaps").setup(_MINV.keymaps)
  -- Auto commands.
  require("preset.autocmds").setup(_MINV.autocmds)
end

return M
