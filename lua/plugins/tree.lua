local M = {}

function M.preset()
  ---@class MiNVPresetTree
  local preset = {
    setup = {
      disable_netrw = true,
      auto_close = false,
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 500,
      },
      view = {
        auto_resize = true,
      },
    },
    keymaps = {
      toggle = "<C-b>",
      focus = "<C-n>",
    },
    filters = {
      [".git"] = true,
      [".cache"] = true,
      ["node_modules"] = true,
    },
  }
  return preset
end

---@param preset MiNVPresetTree
function M.setup(preset)
  local tree = require("nvim-tree")
  local utils = require("utils")

  -- Setup nvim-tree.
  tree.setup(utils.tbl_merge(preset.setup, {
    filters = {
      custom = utils.set_to_list(preset.filters),
    },
  }))

  -- Set keymaps.
  local keymaps = preset.keymaps
  utils.keymaps({
    { keymaps.toggle, "<Cmd>NvimTreeToggle<CR>" },
    { keymaps.focus, "<Cmd>NvimTreeFocus<CR>" },
  })
end

return M
