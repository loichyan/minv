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
      line = "<Plug>(_MiNVCommentToggleLine)",
      block = "<Plug>(_MiNVCommentToggleBlock)",
    },
    opleader = {
      line = "<Plug>(_MiNVCommentOpLine)",
      block = "<Plug>(_MiNVCommentOpBlock)",
    },
    mappings = {
      basic = true,
      extra = false,
      extended = false,
    },
  })
  local utils = require("utils")
  local keymaps = preset.keymaps
  local opts = { noremap = false }
  utils.map("n", keymaps.toggle_line, "<Plug>(_MiNVCommentToggleLine)", opts)
  utils.map("n", keymaps.toggle_block, "<Plug>(_MiNVCommentToggleBlock)", opts)
  utils.map("x", keymaps.toggle_line, "<Plug>(_MiNVCommentOpLine)", opts)
  utils.map("x", keymaps.toggle_block, "<Plug>(_MiNVCommentOpBlock)", opts)
end

return M
