local M = {}

function M.new()
  ---@class MiNV
  local preset = {
    --- Builtin plugins.
    builtin = require("preset.builtin").preset(),
    --- Vim settings.
    settings = require("preset.settings").preset(),
    --- Auto commands.
    autocmds = require("preset.autocmds").preset(),
    --- Keymaps.
    keymaps = require("preset.keymaps").preset(),
    --- Extra plugins.
    ---@type table[]
    extra = {},
  }
  return preset
end

return M
