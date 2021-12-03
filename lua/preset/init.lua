---@class MiNV
local M = {
  --- Builtin plugins.
  builtin = require("preset.builtin"),
  --- Vim settings.
  settings = require("preset.settings").preset(),
  --- Auto commands.
  autocmds = require("preset.autocmds").preset(),
  --- Keymaps.
  keymaps = require("preset.keymaps").preset(),
  --- Extra plugins.
  ---@type table[]|nil
  extra = nil,

  --------------------
  -- Private fields --
  --------------------

  --- Registered functions.
  _registered_funcs = {},
}

return M
