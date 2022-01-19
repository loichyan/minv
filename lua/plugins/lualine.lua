local M = {}

function M.preset()
  ---@class MiNVPresetLualine
  local preset = {
    options = {
      theme = "auto",
    },
    extensions = {
      ["nvim-tree"] = true,
      ["toggleterm"] = true,
    },
  }
  return preset
end

---@param preset MiNVPresetLualine
function M.setup(preset)
  local lualine = require("lualine")
  local utils = require("utils")

  lualine.setup({
    options = preset.options,
    extensions = utils.set_to_list(preset.extensions),
  })
end

return M
