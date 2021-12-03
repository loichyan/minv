local M = {}

function M.preset()
  ---@class MiNVPresetLsp
  local preset = {
    settings = {},
    keymaps = {
      hover = "K",
      format = "<Leader>lf",
    },
    formatters = {},
    linters = {},
  }
  return preset
end

---@param preset MiNVPresetLsp
local function make_sources(null_ls, preset)
  local sources = {}
  for k, v in pairs(preset.formatters) do
    table.insert(sources, null_ls.builtins.formatting[k].with(v))
  end
  for k, v in pairs(preset.linters) do
    table.insert(sources, null_ls.builtins.diagnostics[k].with(v))
  end
  return sources
end

---@param preset MiNVPresetLsp
function M.setup(preset, lspconfig, null_ls, cmp_lsp, lsp_installer)
  local utils = require("utils")
  local function on_attach(_, buf)
    local map = utils.make_buf_map(buf)
    map("n", preset.keymaps.hover, ":lua vim.lsp.buf.hover()<CR>")
    map("n", preset.keymaps.format, ":lua vim.lsp.buf.formatting()<CR>")
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
  null_ls.config({ sources = make_sources(null_ls, preset) })
  lspconfig["null-ls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return M
