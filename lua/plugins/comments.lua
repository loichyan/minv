local M = {}

function M.preset()
  ---@class MiNVPresetComment
  local preset = {
    setup = {},
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

  -- Setup comment.
  local k_tg_line = utils.register_key()
  local k_tg_block = utils.register_key()
  local k_op_line = utils.register_key()
  local k_op_block = utils.register_key()
  comment.setup(utils.tbl_merge(preset.setup, {
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
  }))

  -- Set keymaps.
  local keymaps = preset.keymaps
  utils.keymaps({
    noremap = false,
    { keymaps.toggle_line, k_tg_line },
    { keymaps.toggle_block, k_tg_block },
  })
  utils.keymaps({
    mode = "x",
    noremap = false,
    { keymaps.toggle_line, k_op_line },
    { keymaps.toggle_block, k_op_block },
  })
end

return M
