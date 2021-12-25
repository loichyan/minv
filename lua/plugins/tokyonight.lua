local M = {}

function M.preset()
  ---@class MiNVPresetTokyonight
  local preset = {
    style = "night",
  }
  return preset
end

---@param preset MiNVPresetTokyonight
function M.setup(preset)
  local utils = require("utils")
  utils.g({
    tokyonight_style = preset.style,
  })
  vim.cmd([[colorscheme tokyonight]])
end

return M
