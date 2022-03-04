local M = {}

function M.preset()
  ---@class MiNVPresetTokyonight
  local preset = {
    setup = {
      style = "night",
    },
    after = nil,
  }
  return preset
end

---@param preset MiNVPresetTokyonight
function M.setup(preset)
  local utils = require("utils")

  -- Setup tokyonight.
  utils.g({
    tokyonight_style = preset.setup.style,
  })
  vim.cmd([[colorscheme tokyonight]])
end

return M
