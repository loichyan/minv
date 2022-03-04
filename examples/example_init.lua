local M = {}

---@param minv MiNV
function M.setup(minv)
  -- Load extra plugins.
  require("extra").setup(minv)

  -- Rust
  minv.builtin.treesitter.install["rust"] = true
  minv.builtin.lsp.server_settings.rust_analyzer = {
    ["rust-analyzer"] = {
      experimental = {
        procAttrMacros = true,
      },
    },
  }

  -- Lua
  minv.builtin.lsp.formatters.stylua = {}
end

return M
