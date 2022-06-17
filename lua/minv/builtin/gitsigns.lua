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
end

return M
