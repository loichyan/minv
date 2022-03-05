local M = {}

function M.preset()
  local ok, dv_config = pcall(require, "diffview.config")
  local cb = function(_)
    return nil
  end
  if ok then
    cb = dv_config.diffview_callback
  end

  ---@class MiNVPresetDiffview
  local preset = {
    enable = true,
    setup = {
      enhanced_diff_hl = true,
      file_panel = {
        width = 30,
      },
      key_bindings = {
        view = {
          ["q"] = "<Cmd>DiffviewClose<CR>",
          ["<C-b>"] = cb("toggle_files"),
          ["<C-n>"] = cb("focus_files"),
        },
        file_panel = {
          ["q"] = "<Cmd>DiffviewClose<CR>",
          ["<C-b>"] = cb("toggle_files"),
          ["<C-n>"] = cb("focus_files"),
        },
        file_history_panel = {
          ["q"] = "<Cmd>DiffviewClose<CR>",
          ["<C-b>"] = cb("toggle_files"),
          ["<C-n>"] = cb("focus_files"),
        },
      },
    },
    keymaps = {
      open = "<Leader>gg",
    },
    after = nil,
  }
  return preset
end

---@param preset MiNVPresetDiffview
function M.setup(preset)
  local utils = require("utils")

  -- Setup diffview.
  require("diffview").setup(preset.setup)

  -- Set keymaps.
  local keymaps = preset.keymaps
  utils.keymaps({
    { keymaps.open, "<Cmd>DiffviewOpen<CR>" },
  })
end

return M
