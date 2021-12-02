local M = {}

function M.preset()
  ---@class MiNVPresetLualine
  local preset = {
    setup = {},
  }
  return preset
end

---@param preset MiNVPresetLualine
function M.setup(lualine, preset)
  lualine.setup(preset.setup)
end

return M
