local M = {}

function M.preset()
  return {
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    attach_to_untracked = true,
    current_line_blame = true,
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    preview_config = {
      border = "rounded",
    },
  }
end

---@param minv MiNV
function M.setup(minv)
  -- Setup gitsigns.
  require("gitsigns").setup(minv.plugins.ui.gitsigns)
  minv.keybindings.gitsigns:apply({
    ["gitsigns.goto_next_hunk"] = {
      "<Cmd>Gitsigns next_hunk<CR>",
      "Goto next hunk",
    },
    ["gitsigns.goto_prev_hunk"] = {
      "<Cmd>Gitsigns prev_hunk<CR>",
      "Goto prev hunk",
    },
    ["gitsigns.blame_line"] = { "<Cmd>Gitsigns blame_line<CR>", "Blame line" },
    ["gitsigns.reset_line"] = { "<Cmd>Gitsigns reset_hunk<CR>", "Reset hunk" },
    ["gitsigns.reset_buffer"] = {
      "<Cmd>Gitsigns reset_buffer<CR>",
      "Reset buffer",
    },
    ["gitsigns.state_hunk"] = { "<Cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
    ["gitsigns.stage_buffer"] = {
      "<Cmd>Gitsigns stage_buffer<CR>",
      "Stage buffer",
    },
    ["gitsigns.undo_stage_hunk"] = {
      "<Cmd>Gitsigns undo_stage_hunk<CR>",
      "Undo stage hunk",
    },
    ["gitsigns.preview_hunk"] = {
      "<Cmd>Gitsigns preview_hunk<CR>",
      "Preview hunk",
    },
  })
end

return M
