local M = {}

---@param minv MiNV
function M.setup(minv)
  local lsp_installer = require("nvim-lsp-installer")
  local lspconfig = require("lspconfig")
  local null_ls = require("null-ls")
  local utils = require("utils")
  local preset = minv.builtin.lsp

  local function on_attach(client, buf)
    -- Auto highlight references.
    if client.resolved_capabilities.document_highlight then
      vim.cmd([[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved,CursorMovedI,InsertEnter <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]])
    end
    minv.keybindings.lsp:apply(true, {
      ["lsp.hover"] = {
        "<Cmd>lua vim.lsp.buf.hover()<CR>",
        "Hover",
      },
      ["lsp.show_signature_help"] = {
        "<Cmd>lua vim.lsp.buf.signature_help()<CR>",
        "Show signature help",
      },
      ["lsp.show_diagnostic"] = {
        "<Cmd>lua vim.diagnostic.open_float()<CR>",
        "Show diagnostic",
      },
      ["lsp.goto_definition"] = {
        "<Cmd>lua vim.lsp.buf.definition()<CR>",
        "Goto definition",
      },
      ["lsp.goto_declaration"] = {
        "<Cmd>lua vim.lsp.buf.declaration()<CR>",
        "Goto declaration",
      },
      ["lsp.show_implementation"] = {
        "<Cmd>lua vim.lsp.buf.implementation()<CR>",
        "Show implementation",
      },
      ["lsp.show_references"] = {
        "<Cmd>lua vim.lsp.buf.references()<CR>",
        "Show references",
      },
      ["lsp.show_document_diagnostics"] = {
        "<Cmd>lua vim.diagnostic.setloclist()<CR>",
        "Show document diagnostics",
      },
      ["lsp.show workspace_diagnostics"] = {
        "<Cmd>lua vim.diagnostic.setqflist()<CR>",
        "Show workspace diagnostics",
      },
      ["lsp.goto_next_diagnostic"] = {
        "<Cmd>lua vim.diagnostic.goto_next()<CR>",
        "Goto next diagnostic",
      },
      ["lsp.goto_prev_diagnostic"] = {
        "<Cmd>lua vim.diagnostic.goto_prev()<CR>",
        "Goto prev diagnostic",
      },
      ["lsp.formatting"] = {
        "<Cmd>lua vim.lsp.buf.formatting()<CR>",
        "Formatting",
      },
      ["lsp.rename"] = {
        "<Cmd>lua vim.lsp.buf.rename()<CR>",
        "Rename",
      },
    }, { buffer = buf })
  end
  local capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )

  local debounce = 150

  -- TODO: add hooks to minv
  local function on_server_setup(name, setup_server)
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = preset.servers[name],
      flags = {
        debounce_text_changes = debounce,
      },
    }
    setup_server(opts)
  end

  -- Install not installed servers.
  local installed_servers = utils.list_to_set(
    require("nvim-lsp-installer.servers").get_installed_server_names()
  )
  for _, name in ipairs(preset.install) do
    if installed_servers[name] ~= true then
      lsp_installer.install(name)
    end
  end

  -- Setup servers not installed.
  for name, _ in pairs(preset.servers) do
    if installed_servers[name] ~= true then
      on_server_setup(name, lspconfig[name].setup)
    end
  end

  -- Setup installed servers.
  lsp_installer.on_server_ready(function(server)
    on_server_setup(server.name, function(...)
      server:setup(...)
    end)
  end)

  -- Load null-ls sources.
  local sources = {}
  for k, v in pairs(preset.formatters) do
    table.insert(sources, null_ls.builtins.formatting[k].with(v))
  end
  for k, v in pairs(preset.linters) do
    table.insert(sources, null_ls.builtins.diagnostics[k].with(v))
  end

  -- Setup null-ls.
  null_ls.setup({
    on_attach = on_attach,
    sources = sources,
    debounce = debounce,
  })

  -- Set border of popup windows.
  local open_float_preview = vim.lsp.util.open_floating_preview
  vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = minv.settings.border
    return open_float_preview(contents, syntax, opts, ...)
  end
end

return M
