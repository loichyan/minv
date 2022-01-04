local M = {}

function M.preset()
  ---@class MiNVPresetTree
  local preset = {
    keymaps = {
      toggle = "<C-n>",
    },
    filters = { [".git"] = true, [".cache"] = true, ["node_modules"] = true },
  }
  return preset
end

---@param preset MiNVPresetTree
function M.setup(preset, tree)
  local utils = require("utils")
  tree.setup({
    filters = {
      dotfiles = false,
      custom = utils.set_to_list(preset.filters),
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 500,
    },
  })
  local keymaps = preset.keymaps
  utils.map("n", keymaps.toggle, "<Cmd>NvimTreeToggle<CR>")
end

return M
