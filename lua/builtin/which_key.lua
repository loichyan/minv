local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVPresetWhichKey
  local preset = {
    setup = {
      ignore_missing = true,
    },
    after = utils.callback.new(),
  }
  return preset
end

---@param preset MiNVPresetWhichKey
function M.setup(preset)
  require("which-key").setup(preset.setup)
end

return M
