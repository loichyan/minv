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
function M.setup(preset)
  local comment = require("Comment")
  local utils = require("utils")

  local k_tg_line = utils._register_key()
  local k_tg_block = utils._register_key()
  local k_op_line = utils._register_key()
  local k_op_block = utils._register_key()
  comment.setup({
    toggler = {
      line = k_tg_line,
      block = k_tg_block,
    },
    opleader = {
      line = k_op_line,
      block = k_op_block,
    },
    mappings = {
      basic = true,
      extra = false,
      extended = false,
    },
  })
  local keymaps = preset.keymaps
  local opts = { noremap = false }
  utils.map("n", keymaps.toggle_line, k_tg_line, opts)
  utils.map("n", keymaps.toggle_block, k_tg_block, opts)
  utils.map("x", keymaps.toggle_line, k_op_line, opts)
  utils.map("x", keymaps.toggle_block, k_op_block, opts)
end

return M
