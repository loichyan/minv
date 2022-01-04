local M = {}

---@param minv MiNV
function M.setup(minv)
  -- Add extra plugins.
  minv.extra = {
    {
      "tpope/vim-fugitive",
      config = function()
        local utils = require("utils")
        utils.map("n", "<Leader>gg", "<Cmd>Git<CR>")
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
