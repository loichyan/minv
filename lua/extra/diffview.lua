local M = {}

function M.preset()
  local utils = require("utils")

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
    keymaps = utils.keymap.new({
      ["<Leader>g"] = {
        ["g"] = { "<Cmd>DiffviewOpen<CR>", "Open diffview" },
      },
    }),
    after = utils.callback.new(),
  }
  return preset
end

---@param preset MiNVPresetDiffview
function M.setup(preset)
  -- Setup diffview.
  require("diffview").setup(preset.setup)

  -- Set keymaps.
  preset.keymaps:apply()
end

return M
