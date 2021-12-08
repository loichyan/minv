local M = {}

function M.preset()
  ---@class MiNVPresetGitsigns
  local preset = {}
  return preset
end

---@param preset MiNVPresetGitsigns
function M.setup(preset, gitsigns)
  gitsigns.setup({})
end

return M
