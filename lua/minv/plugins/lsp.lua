--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____keybindings = require("minv.keybindings")
local apply_mappings = ____keybindings.apply_mappings
local ____presets = require("minv.presets")
local PRESETS = ____presets.PRESETS
local ____utils = require("minv.utils")
local deep_merge = ____utils.deep_merge
local MAPPINGS = {
    ["lsp.formatting"] = {cmd = "<Cmd>lua vim.lsp.buf.formatting()<CR>", desc = "Formatting"},
    ["lsp.goto_declaration"] = {cmd = "<Cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Goto declaration"},
    ["lsp.goto_definition"] = {cmd = "<Cmd>lua vim.lsp.buf.definition()<CR>", desc = "Goto definition"},
    ["lsp.goto_next_diagnostic"] = {cmd = "<Cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Goto next diagnostic"},
    ["lsp.goto_next_error"] = {cmd = "<Cmd>lua vim.diagnostic.goto_next({ severity : vim.diagnostic.severity.ERROR })<CR>", desc = "Goto next error"},
    ["lsp.goto_prev_diagnostic"] = {cmd = "<Cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Goto prev diagnostic"},
    ["lsp.goto_prev_error"] = {cmd = "<Cmd>lua vim.diagnostic.goto_prev({ severity : vim.diagnostic.severity.ERROR })<CR>", desc = "Goto prev error"},
    ["lsp.hover"] = {cmd = "<Cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover"},
    ["lsp.rename"] = {cmd = "<Cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename"},
    ["lsp.show_code_action"] = {cmd = "<Cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Show code action"},
    ["lsp.show_diagnostic"] = {cmd = "<Cmd>lua vim.diagnostic.open_float()<CR>", desc = "Show diagnostic"},
    ["lsp.show_document_diagnostics"] = {cmd = "<Cmd>lua vim.diagnostic.setloclist()<CR>", desc = "Show document diagnostics"},
    ["lsp.show_implementation"] = {cmd = "<Cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Show implementation"},
    ["lsp.show_references"] = {cmd = "<Cmd>lua vim.lsp.buf.references()<CR>", desc = "Show references"},
    ["lsp.show_signature_help"] = {cmd = "<Cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Show signature help"},
    ["lsp.show_workspace_diagnostics"] = {cmd = "<Cmd>lua vim.diagnostic.setqflist()<CR>", desc = "Show workspace diagnostics"}
}
local function on_attach(client, buffer)
    if client.resolved_capabilities.document_highlight == true then
        vim.cmd("\n      augroup lsp_document_highlight\n        autocmd! * <buffer>\n        autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()\n        autocmd CursorMoved,CursorMovedI,InsertEnter <buffer> lua vim.lsp.buf.clear_references()\n      augroup END\n    ")
    end
    apply_mappings(MAPPINGS, {buffer = buffer})
end
function ____exports.setup_lspconfig()
    local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if ok then
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
    end
    local preset = PRESETS.lspconfig
    for name, conf in pairs(preset.servers) do
        local opts = deep_merge(
            "keep",
            {
                on_attach = function(client, buffer)
                    on_attach(client, buffer)
                    if conf.on_attach ~= nil then
                        conf.on_attach()
                    end
                end,
                capabilities = capabilities
            },
            preset.server_default
        )
        require("lspconfig")[name].setup(opts)
    end
    local open_floating_preview = vim.lsp.util.open_floating_preview
    vim.lsp.util.open_floating_preview = function(____, contents, syntax, opts, ...)
        opts = opts or ({})
        opts.border = opts.border or preset.border
        return open_floating_preview(contents, syntax, opts, ...)
    end
    require("lspconfig.ui.windows").default_options.border = "single"
end
function ____exports.setup_null_ls()
    local null_ls = require("null-ls")
    local sources = {}
    local preset_sources = PRESETS.null_ls_sources
    for k, v in pairs(preset_sources.formatters) do
        table.insert(
            sources,
            null_ls.builtins.formatting[k].with(v)
        )
    end
    for k, v in pairs(preset_sources.linters) do
        table.insert(
            sources,
            null_ls.builtins.diagnostics[k].with(v)
        )
    end
    null_ls.setup(deep_merge("keep", {on_attach = on_attach, sources = sources}, PRESETS.null_ls))
end
return ____exports
