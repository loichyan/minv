local M = {}

function M.preset()
  ---@class MiNVPresetLsp
  local preset = {
    options = {
      popup_border = "single",
    },
    keymaps = {
      hover = "K",
      signature_help = "gk",
      show_line_diagnostics = "ge",
      definition = "gd",
      declaration = "gD",
      implementation = "gI",
      references = "gr",
      document_diagnostics = "<Leader>le",
      workspace_diagnostics = "<Leader>lE",
      goto_next = "<Leader>lj",
      goto_prev = "<Leader>lk",
      rename = "<Leader>lr",
      formatting = "<Leader>lf",
    },
    server_settings = {},
    formatters = {},
    linters = {},
  }
  return preset
end

---@param preset MiNVPresetLsp
function M.setup(preset, lspconfig, null_ls, cmp_lsp, lsp_installer)
  local utils = require("utils")

  --- Set keymaps.
  local function set_keymaps(buf)
    local map = utils.make_buf_map(buf)
    local km = preset.keymaps
    map("n", km.hover, ":lua vim.lsp.buf.hover()<CR>")
    map("n", km.signature_help, ":lua vim.lsp.buf.signature_help()<CR>")
    map(
      "n",
      km.show_line_diagnostics,
      string.format(
        [[:lua vim.lsp.diagnostic.show_line_diagnostics({ border = "%s" })<CR>]],
        preset.options.popup_border
      )
    )
    map("n", km.definition, ":lua vim.lsp.buf.definition()<CR>")
    map("n", km.declaration, ":lua vim.lsp.buf.declaration()<CR>")
    map("n", km.implementation, ":Telescope lsp_implementations<CR>")
    map("n", km.references, ":Telescope lsp_references<CR>")
    map("n", km.document_diagnostics, ":Telescope lsp_document_diagnostics<CR>")
    map("n", km.workspace_diagnostics, ":Telescope lsp_workspace_diagnostics<CR>")
    map("n", km.goto_next, ":lua vim.lsp.diagnostic.goto_next()<CR>")
    map("n", km.goto_prev, ":lua vim.lsp.diagnostic.goto_prev()<CR>")
    map("n", km.formatting, ":lua vim.lsp.buf.formatting()<CR>")
    map("n", km.rename, ":lua vim.lsp.buf.rename()<CR>")
  end

  local function make_sources()
    local sources = {}
    for k, v in pairs(preset.formatters) do
      table.insert(sources, null_ls.builtins.formatting[k].with(v))
    end
    for k, v in pairs(preset.linters) do
      table.insert(sources, null_ls.builtins.diagnostics[k].with(v))
    end
    return sources
  end

  local on_attach = function(_, buf)
    set_keymaps(buf)
  end
  local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- Setup installed servers.
  lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = preset.server_settings[server.name],
    }
    server:setup(opts)
  end)

  -- Setup null-ls.
  null_ls.setup({ sources = make_sources() })

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
