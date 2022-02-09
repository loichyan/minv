local M = {}

function M.preset()
  ---@class MiNVPresetGitsigns
  local preset = {
    options = {
      current_line_blame = true,
    },
    keymaps = {
      next_hunk = "<Leader>gj",
      prev_hunk = "<Leader>gk",
      blame_line = "<Leader>gb",
      reset_hunk = "<Leader>gr",
      reset_buffer = "<Leader>gR",
      stage_hunk = "<Leader>gs",
      stage_buffer = "<Leader>gS",
      undo_stage_hunk = "<Leader>gu",
      preview_hunk = "<Leader>gp",
    },
  }
  return preset
end

---@param preset MiNVPresetGitsigns
function M.setup(preset)
  local gitsigns = require("gitsigns")
  local utils = require("utils")

  -- Setup gitsigns.
  local opts = preset.options
  gitsigns.setup({
    current_line_blame = opts.current_line_blame,
  })
  -- Set keymaps.
  local keymaps = preset.keymaps
  utils.keymaps({
    { keymaps.next_hunk, "<Cmd>Gitsigns next_hunk<CR>" },
    { keymaps.prev_hunk, "<Cmd>Gitsigns prev_hunk<CR>" },
    { keymaps.blame_line, "<Cmd>Gitsigns blame_line<CR>" },
    { keymaps.reset_hunk, "<Cmd>Gitsigns reset_hunk<CR>" },
    { keymaps.reset_buffer, "<Cmd>Gitsigns reset_buffer<CR>" },
    { keymaps.stage_hunk, "<Cmd>Gitsigns stage_hunk<CR>" },
    { keymaps.stage_buffer, "<Cmd>Gitsigns stage_buffer<CR>" },
    { keymaps.undo_stage_hunk, "<Cmd>Gitsigns undo_stage_hunk<CR>" },
    { keymaps.preview_hunk, "<Cmd>Gitsigns preview_hunk<CR>" },
  })
end

return M
