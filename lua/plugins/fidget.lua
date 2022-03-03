local M = {}

function M.preset()
  ---@class MiNVPresetFidget
  local preset = {
    enable = true,
    setup = {},
    after = nil,
  }
  return preset
end

---@param preset MiNVPresetFidget
function M.setup(preset)
  -- Setup fidget.
  require("fidget").setup(preset.setup)
end

return M
