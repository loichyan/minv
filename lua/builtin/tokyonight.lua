local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVPresetTokyonight
  local preset = {
    after = utils.callback.new(),
    setup = {
      style = "night",
    },
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
