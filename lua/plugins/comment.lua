local M = {}

function M.preset()
  ---@class MiNVPresetComment
  local preset = {
    keymaps = {
      toggle_line = "<Leader>/",
      toggle_block = "<Leader>a/",
    },
  }
  return preset
end

---@param preset MiNVPresetComment
function M.setup(comment, preset)
  comment.setup({
    toggler = {
      line = "<Plug>CommentToggleLine",
      block = "<Plug>CommentToggleBlock",
    },
    opleader = {
      line = "<Plug>CommentOpLine",
      block = "<Plug>CommentOpBlock",
    },
    mappings = {
      basic = true,
      extra = false,
      extended = false,
    },
  })
  local utils = require("utils")
  local keymaps = preset.keymaps
  utils.map("n", keymaps.toggle_line, "<Plug>CommentToggleLine", { noremap = false })
  utils.map("n", keymaps.toggle_block, "<Plug>CommentToggleBlock", { noremap = false })
  utils.map("x", keymaps.toggle_line, "<Plug>CommentOpLine", { noremap = false })
  utils.map("x", keymaps.toggle_block, "<Plug>CommentOpBlock", { noremap = false })
end

return M
