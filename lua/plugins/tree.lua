local M = {}

function M.preset()
  ---@class MiNVPresetTree
  local preset = {
    keymaps = {
      toggle = "<C-n>",
    },
  }
  return preset
end

---@param preset MiNVPresetTree
function M.setup(preset, tree)
  tree.setup({})
  local utils = require("utils")
  local keymaps = preset.keymaps
  utils.map("n", keymaps.toggle, ":NvimTreeToggle<CR>")
end

return M
