local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVPresetDiffview
  local preset = {
    enable = true,
    after = utils.callback.new(),
    setup = utils.lazy.new(function()
      local cb = require("diffview.config").diffview_callback
      ---@class MiNVExtraDiffviewSetup
      local setup = {
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
      }
      return setup
    end),
    keymaps = utils.keymap.new({
      ["<Leader>g"] = {
        ["g"] = { "<Cmd>DiffviewOpen<CR>", "Open diffview" },
      },
    }),
  }
  return preset
end

---@param preset MiNVPresetDiffview
function M.setup(preset)
  -- Setup diffview.
  require("diffview").setup(preset.setup:apply())

  -- Set keymaps.
  preset.keymaps:apply()
end

return M
