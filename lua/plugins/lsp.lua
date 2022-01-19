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
function M.setup(preset)
  local cmp_lsp = require("cmp_nvim_lsp")
  local lsp_installer = require("nvim-lsp-installer")
  local lsp_installer_servers = require("nvim-lsp-installer.servers")
  local lspconfig = require("lspconfig")
  local null_ls = require("null-ls")
  local trouble = require("trouble")
  local utils = require("utils")

  --- Set keymaps.
  local function set_keymaps(buf)
    local map = utils.make_buf_map(buf)
    local km = preset.keymaps
    map("n", km.hover, "<Cmd>lua vim.lsp.buf.hover()<CR>")
    map("n", km.signature_help, "<Cmd>lua vim.lsp.buf.signature_help()<CR>")
    map(
      "n",
      km.show_line_diagnostics,
      string.format(
        [[<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "%s" })<CR>]],
        preset.options.popup_border
      )
    )
    map("n", km.definition, "<Cmd>lua vim.lsp.buf.definition()<CR>")
    map("n", km.declaration, "<Cmd>lua vim.lsp.buf.declaration()<CR>")
    map("n", km.implementation, "<Cmd>Trouble lsp_implementations<CR>")
    map("n", km.references, "<Cmd>Trouble lsp_references<CR>")
    map("n", km.document_diagnostics, "<Cmd>Trouble document_diagnostics<CR>")
    map("n", km.workspace_diagnostics, "<Cmd>Trouble workspace_diagnostics<CR>")
    map("n", km.goto_next, "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
    map("n", km.goto_prev, "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
    map("n", km.formatting, "<Cmd>lua vim.lsp.buf.formatting()<CR>")
    map("n", km.rename, "<Cmd>lua vim.lsp.buf.rename()<CR>")
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

  local function on_attach(client, buf)
    if client.resolved_capabilities.document_highlight then
      vim.cmd([[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved,InsertEnter <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]])
    end
    set_keymaps(buf)
  end
  local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
  local function make_opts(settings)
    return {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
      settings = settings,
    }
  end

  -- Setup servers not installed.
  local installed_servers = lsp_installer_servers.get_installed_server_names()
  for k, v in pairs(preset.server_settings) do
    if installed_servers[k] == nil then
      lspconfig[k].setup(make_opts(v))
    end
  end

  -- Setup installed servers.
  lsp_installer.on_server_ready(function(server)
    server:setup(make_opts(preset.server_settings[server.name]))
  end)

  -- Setup null-ls.
  null_ls.setup({
    debounce = 150,
    on_attach = on_attach,
    sources = make_sources(),
  })

  -- Setup trouble.
  trouble.setup({})

  -- Set border of popup windows.
  local open_float_preview = vim.lsp.util.open_floating_preview
  vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = preset.options.popup_border
    return open_float_preview(contents, syntax, opts, ...)
  end
end

return M
