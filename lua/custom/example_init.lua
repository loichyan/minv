local M = {}

---@param minv MiNV
function M.setup(minv)
  -- Add extra plugins.
  minv.extra = {
    {
      "folke/tokyonight.nvim",
      config = function()
        require("utils").g({
          tokyonight_style = "night",
        })
        vim.cmd([[colorscheme tokyonight]])
      end,
    },
  }
  -- Set configs of built-in plugins.
  minv.builtin.lualine.setup = {
    options = {
      theme = "tokyonight",
    },
  }
end

return M
