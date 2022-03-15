local M = {}

function M.preset()
  return {
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    view = {
      auto_resize = true,
    },
    filters = {
      custom = {
        ".git",
        ".cache",
        "node_modules",
      },
    },
  }
end

---@param minv MiNV
function M.setup(minv)
  -- Setup nvim-tree.
  require("nvim-tree").setup(minv.builtin.tree)
end

return M
