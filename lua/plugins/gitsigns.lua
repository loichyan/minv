local M = {}

function M.preset()
  ---@class MiNVPresetGitsigns
  local preset = {
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
    options = {
      current_line_blame = true,
    },
  }
  return preset
end

---@param preset MiNVPresetGitsigns
function M.setup(preset, gitsigns)
  local utils = require("utils")
  -- Setup gitsigns.
  local opts = preset.options
  gitsigns.setup({
    current_line_blame = opts.current_line_blame,
  })
  -- Set keymaps.
  local km = preset.keymaps
  utils.map("n", km.next_hunk, ":Gitsigns next_hunk<CR>")
  utils.map("n", km.prev_hunk, ":Gitsigns prev_hunk<CR>")
  utils.map("n", km.blame_line, ":Gitsigns blame_line<CR>")
  utils.map("n", km.reset_hunk, ":Gitsigns reset_hunk<CR>")
  utils.map("n", km.reset_buffer, ":Gitsigns reset_buffer<CR>")
  utils.map("n", km.stage_hunk, ":Gitsigns stage_hunk<CR>")
  utils.map("n", km.stage_buffer, ":Gitsigns stage_buffer<CR>")
  utils.map("n", km.undo_stage_hunk, ":Gitsigns undo_stage_hunk<CR>")
  utils.map("n", km.preview_hunk, ":Gitsigns preview_hunk<CR>")
end

return M
