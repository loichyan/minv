local M = {}

function M.preset()
  return {
    ---Configs passed to all servers.
    server_default = {
      flags = {
        debounce_text_changes = 250,
      },
    },
    ---Configs passed to servers of `lsp-config`.
    servers = {
      sumneko_lua = {},
    },
    ---Additional `null-ls` formatters.
    formatters = {},
    ---Additional `null-ls` linters.
    linters = {},
    border = "rounded",
  }
end

local keybindings = {
  ["lsp.hover"] = {
    "<Cmd>lua vim.lsp.buf.hover()<CR>",
    "Hover",
  },
  ["lsp.show_code_action"] = {
    "<Cmd>lua vim.lsp.buf.code_action()<CR>",
    "Show code action",
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
  ["lsp.goto_next_error"] = {
    "<Cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>",
    "Goto next error",
  },
  ["lsp.goto_prev_error"] = {
    "<Cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>",
    "Goto prev error",
  },
  ["lsp.formatting"] = {
    "<Cmd>lua vim.lsp.buf.formatting()<CR>",
    "Formatting",
  },
  ["lsp.rename"] = {
    "<Cmd>lua vim.lsp.buf.rename()<CR>",
    "Rename",
  },
}

---@param minv MiNV
function M.setup(minv)
  local lspconfig = require("lspconfig")
  local null_ls = require("null-ls")
  local preset = minv.plugins.lsp
  local config = preset.config

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
    minv.keybindings.lsp:apply(keybindings, { buffer = buf })
  end

  local capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )

  -- Setup lsp-installer
  require("nvim-lsp-installer").setup(preset.installer)

  -- Setup LSP servers.
  for name, conf in pairs(config.servers) do
    local opts = vim.tbl_extend("force", config.server_default, conf, {
      on_attach = function(cilent, buf)
        on_attach(cilent, buf)
        if conf.on_attach ~= nil then
          conf.on_attach(cilent, buf)
        end
      end,
      capabilities = capabilities,
    })
    lspconfig[name].setup(opts)
  end

  -- Collect null-ls sources.
  local sources = {}
  for k, v in pairs(config.formatters) do
    table.insert(sources, null_ls.builtins.formatting[k].with(v))
  end
  for k, v in pairs(config.linters) do
    table.insert(sources, null_ls.builtins.diagnostics[k].with(v))
  end

  -- Setup null-ls.
  null_ls.setup(vim.tbl_extend("force", preset.null_ls, {
    on_attach = on_attach,
    sources = sources,
  }))

  -- Set border of popup windows.
  local open_float_preview = vim.lsp.util.open_floating_preview
  vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = config.border
    return open_float_preview(contents, syntax, opts, ...)
  end
end

return M
