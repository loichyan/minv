local settings = require("preset.settings")

---@class MiNV
local M = {
  -- Builtin plugins.
  builtin = require("preset.builtin"),
  -- Vim globals.
  g = settings.g,
  -- Vim options.
  o = settings.o,
  -- Auto commands.
  au = require("preset.autocmds"),
  -- Keymaps.
  keymaps = require("preset.keymaps"),
  -- Extra plugins.
  ---@type table[]|nil
  extra = nil,
}

return M
