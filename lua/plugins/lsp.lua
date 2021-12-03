local M = {}

function M.preset()
  ---@class MiNVPresetLsp
  local preset = {
    settings = {},
    keymaps = {
      hover = "K",
    },
    formatters = {},
    linters = {},
  }
  return preset
end

---@param preset MiNVPresetLsp
function M.setup(lspconfig, null_ls, cmp_lsp, lsp_installer, preset)
  local utils = require("utils")
  local function on_attach(_, buf)
    local map = utils.make_buf_map(buf)
    map("n", preset.keymaps.hover, ":lua vim.lsp.buf.hover()<CR>")
  end
  -- Completion.
  local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Setup installed servers.
  lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = preset.settings[server.name],
    }
    server:setup(opts)
  end)
  -- Setup null-ls.
  -- TODO: add sources
  null_ls.config({ sources = nil })
  lspconfig["null-ls"].setup({})
end

return M
