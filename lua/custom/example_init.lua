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
  -- Set theme of lualine.
  minv.builtin.lualine.setup = {
    options = {
      theme = "tokyonight",
    },
  }
  -- Rust analyzer.
  minv.builtin.lsp.settings.rust_analyzer = {
    ["rust-analyzer"] = {
      experimental = {
        procAttrMacros = true,
      },
    },
  }
end

return M
