local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVPresetTree
  local preset = {
    after = utils.callback.new(),
    setup = {
      disable_netrw = true,
      auto_close = false,
      update_cwd = true,
      update_focused_file = {
        enable = true,
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
    keymaps = utils.keymap.new({
      ["<C-b>"] = "<Cmd>NvimTreeToggle<CR>",
      ["<C-n>"] = "<Cmd>NvimTreeFocus<CR>",
    }),
    filters = utils.set.new({
      ".git",
      ".cache",
      "node_modules",
    }),
  }
  return preset
end

---@param preset MiNVPresetTree
function M.setup(preset)
  local utils = require("utils")

  -- Setup nvim-tree.
  require("nvim-tree").setup(utils.tbl_merge(preset.setup, {
    filters = {
      custom = preset.filters:to_list(),
    },
  }))

  -- Set keymaps.
  preset.keymaps:apply()
end

return M
