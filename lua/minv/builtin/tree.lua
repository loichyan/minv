local M = {}

function M.preset()
  return {
    respect_buf_cwd = true,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 500,
    },
    filters = {
      custom = {
        [[^\.git$]],
        [[^\.cache$]],
        [[^node_modules$]],
      },
    },
  }
end

---@param minv MiNV
function M.setup(minv)
  local preset = minv.builtin.tree
  -- Setup nvim-tree.
  require("nvim-tree").setup(preset)
end

return M
