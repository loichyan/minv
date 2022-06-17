local M = {}

function M.preset()
  return {
    ---Treesitters to be installed.
    ensure_installed = {
      "lua",
    },
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
    },
  }
end

---@param minv MiNV
function M.setup(minv)
  -- Setup treesitter.
  require("nvim-treesitter.configs").setup(minv.plugins.treesitter.config)
end

return M
