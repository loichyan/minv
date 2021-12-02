local M = {}

function M.preset()
  ---@class MiNVPresetLualine
  local preset = {
    setup = {},
  }
  return preset
end

---@param preset MiNVPresetLualine
function M.setup(plug, preset)
  plug.setup(preset.setup)
end

return M
