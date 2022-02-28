local M = {}

function M.preset()
  ---@class MiNVPresetLualine
  local preset = {
    setup = {
      options = {
        theme = "auto",
      },
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

  -- Setup lualine.
  lualine.setup(utils.tbl_merge(preset.setup, {
    extensions = utils.set_to_list(preset.extensions),
  }))
end

return M
