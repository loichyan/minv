local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVPresetLsp
  local preset = {
    after = utils.callback.new(),
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
    },
    keymaps = utils.keymap.new({
      ["K"] = "<Cmd>lua vim.lsp.buf.hover()<CR>",
      ["g"] = {
        ["k"] = { "<Cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help" },
        ["e"] = { "<Cmd>lua vim.diagnostic.open_float()<CR>", "Show diagnostic" },
        ["d"] = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Goto definition" },
        ["D"] = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
        ["I"] = { "<Cmd>lua vim.lsp.buf.implementation()<CR>", "Show implementation" },
        ["r"] = { "<Cmd>lua vim.lsp.buf.references()<CR>", "Show references" },
      },
      ["<Leader>l"] = {
        name = "Lsp",
        ["e"] = { "<Cmd>lua vim.diagnostic.setloclist()<CR>", "Show document diagnostics" },
        ["E"] = { "<Cmd>lua vim.diagnostic.setqflist()<CR>", "Show workspace diagnostics" },
        ["j"] = { "<Cmd>lua vim.diagnostic.goto_next()<CR>", "Goto next diagnostic" },
        ["k"] = { "<Cmd>lua vim.diagnostic.goto_prev()<CR>", "Goto prev diagnostic" },
        ["f"] = { "<Cmd>lua vim.lsp.buf.formatting()<CR>", "Formatting" },
        ["r"] = { "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      },
    }),
    install = utils.set.new({
      "sumneko_lua",
    }),
    on_attach = utils.callback.new(),
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
  local utils = require("utils")

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
    preset.keymaps:apply({ buffer = buf })
    preset.on_attach:apply(buf)
  end
  local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

  local installed_servers = utils.set.new(lsp_installer_servers.get_installed_server_names())
  -- Install not installed servers.
  for _, name in ipairs(preset.install:to_list()) do
    if not installed_servers:has(name) then
      lsp_installer.install(name)
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

  -- Set border of popup windows.
  local open_float_preview = vim.lsp.util.open_floating_preview
  vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = preset.setup.lsp.border
    return open_float_preview(contents, syntax, opts, ...)
  end
end

return M
