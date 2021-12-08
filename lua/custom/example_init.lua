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
  -- Rust analyzer.
  minv.builtin.lsp.server_settings.rust_analyzer = {
    ["rust-analyzer"] = {
      experimental = {
        procAttrMacros = true,
      },
    },
  }
  -- Extra formatters.
  minv.builtin.lsp.formatters.prettierd = {}
end

return M
