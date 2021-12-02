---@class MiNV
local M = {
  -- Builtin plugins.
  builtin = require("preset.builtin"),
  -- Vim settings.
  settings = require("preset.settings"),
  -- Auto commands.
  autocmds = require("preset.autocmds"),
  -- Keymaps.
  keymaps = require("preset.keymaps"),
  -- Extra plugins.
  ---@type table[]|nil
  extra = nil,
}

return M
