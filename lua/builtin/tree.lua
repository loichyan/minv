local M = {}

---@param minv MiNV
function M.setup(minv)
  local preset = minv.builtin.tree
  -- Setup nvim-tree.
  vim.g.nvim_tree_respect_buf_cwd = preset.respect_buf_cwd
  require("nvim-tree").setup({
    update_cwd = preset.update_cwd,
    update_focused_file = preset.update_focused_file,
    git = preset.git,
    view = preset.view,
    filters = preset.filters,
  })
end

return M
