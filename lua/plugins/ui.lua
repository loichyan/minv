local M = {}

function M.preset()
  ---@class MiNVPresetUI
  local preset = {
    setup = {
      todo_comments = {},
      fidget = {},
      notify = {
        max_width = 70,
      },
      tokyonight = {
        style = "night",
      },
    },
  }
  return preset
end

---@param preset MiNVPresetUI
function M.setup(preset)
  local utils = require("utils")
  local todo_comments = require("todo-comments")
  local fidget = require("fidget")
  local notify = require("notify")

  -- Setup todo-comments.
  todo_comments.setup(preset.setup.todo_comments)

  -- Setup fidget.
  fidget.setup(preset.setup.fidget)

  -- Setup notify
  notify.setup(preset.setup.notify)
  vim.notify = notify

  -- Setup tokyonight.
  utils.g({
    tokyonight_style = preset.setup.tokyonight.style,
  })
  vim.cmd([[colorscheme tokyonight]])
end

return M
