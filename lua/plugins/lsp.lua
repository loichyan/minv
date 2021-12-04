local M = {}

function M.preset()
  ---@class MiNVPresetLsp
  local preset = {
    options = {
      popup_border = "single",
    },
    keymaps = {
      hover = "K",
      formatting = "<Leader>lf",
      declaration = "gD",
      definition = "gd",
      implementation = "gi",
      signature_help = "gk",
      references = "gr",
    },
    lsp_settings = {},
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
    local keymaps = preset.keymaps
    map("n", keymaps.hover, ":lua vim.lsp.buf.hover()<CR>")
    map("n", keymaps.formatting, ":lua vim.lsp.buf.formatting()<CR>")
    map("n", keymaps.declaration, ":lua vim.lsp.buf.declaration()<CR>")
    map("n", keymaps.definition, ":lua vim.lsp.buf.definition()<CR>")
    map("n", keymaps.implementation, ":lua vim.lsp.buf.implementation()<CR>")
    map("n", keymaps.signature_help, ":lua vim.lsp.buf.signature_help()<CR>")
    map("n", keymaps.references, ":lua vim.lsp.buf.references()<CR>")
  end
  -- Completion.
  local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Setup installed servers.
  lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = preset.lsp_settings[server.name],
    }
    server:setup(opts)
  end)
  -- Setup null-ls.
  null_ls.config({ sources = make_sources(null_ls, preset) })
  lspconfig["null-ls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
  -- Set border of popup windows.
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = preset.options.popup_border }
  )
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = preset.options.popup_border }
  )
end

return M
