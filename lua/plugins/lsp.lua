local M = {}

function M.preset()
  ---@class MiNVPresetLsp
  local preset = {
    setup = {
      lsp = {
        border = "rounded",
      },
      lspconfig = {
        flags = {
          debounce_text_changes = 150,
        },
      },
      null_ls = {
        debounce = 150,
      },
      trouble = {
        indent_lines = false,
        auto_close = true,
      },
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
    after = nil,
    install = {
      ["sumneko_lua"] = true,
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
    local keymaps = preset.keymaps
    utils.keymaps({
      buffer = buf,
      { keymaps.hover, "<Cmd>lua vim.lsp.buf.hover()<CR>" },
      { keymaps.signature_help, "<Cmd>lua vim.lsp.buf.signature_help()<CR>" },
      {
        keymaps.show_line_diagnostics,
        "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
      },
      { keymaps.definition, "<Cmd>lua vim.lsp.buf.definition()<CR>" },
      { keymaps.declaration, "<Cmd>lua vim.lsp.buf.declaration()<CR>" },
      { keymaps.implementation, "<Cmd>Trouble lsp_implementations<CR>" },
      { keymaps.references, "<Cmd>Trouble lsp_references<CR>" },
      { keymaps.document_diagnostics, "<Cmd>Trouble document_diagnostics<CR>" },
      { keymaps.workspace_diagnostics, "<Cmd>Trouble workspace_diagnostics<CR>" },
      { keymaps.goto_next, "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>" },
      { keymaps.goto_prev, "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>" },
      { keymaps.formatting, "<Cmd>lua vim.lsp.buf.formatting()<CR>" },
      { keymaps.rename, "<Cmd>lua vim.lsp.buf.rename()<CR>" },
    })
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

  local installed_servers = utils.list_to_set(lsp_installer_servers.get_installed_server_names())
  -- Install not installed servers.
  for k, v in pairs(preset.install) do
    if v and not installed_servers[k] then
      lsp_installer.install(k)
    end
  end

  local function on_server_setup(name, setup)
    local opts = utils.tbl_merge(preset.setup.lspconfig, {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = preset.server_settings[name],
    })
    if name == "sumneko_lua" then
      local luadev = require("lua-dev").setup({ lspconfig = opts })
      setup(luadev)
    else
      setup(opts)
    end
  end

  -- Setup servers not installed.
  for name, _ in pairs(preset.server_settings) do
    if installed_servers[name] == nil then
      on_server_setup(name, lspconfig[name].setup)
    end
  end

  -- Setup installed servers.
  lsp_installer.on_server_ready(function(server)
    on_server_setup(server.name, function(...)
      server:setup(...)
    end)
  end)

  -- Setup null-ls.
  null_ls.setup(utils.tbl_merge(preset.setup.null_ls, {
    on_attach = on_attach,
    sources = make_sources(),
  }))

  -- Setup trouble.
  trouble.setup(preset.setup.trouble)

  -- Set border of popup windows.
  local open_float_preview = vim.lsp.util.open_floating_preview
  vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = preset.setup.lsp.border
    return open_float_preview(contents, syntax, opts, ...)
  end
end

return M
