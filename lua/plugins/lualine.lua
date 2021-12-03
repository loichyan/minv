local M = {}

function M.preset()
  ---@class MiNVPresetLualine
  local preset = {
    options = {
      theme = "auto",
    },
  }
  return preset
end

---@param preset MiNVPresetLualine
function M.setup(lualine, preset)
  local setup = {
    options = preset.options,
  }
  lualine.setup(setup)
end

return M
