--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____keybindings = require("minv.keybindings")
local apply_extra = ____keybindings.apply_extra
local apply_mappings = ____keybindings.apply_mappings
local ____presets = require("minv.presets")
local PRESETS = ____presets.PRESETS
local ____utils = require("minv.utils")
local autocmd = ____utils.autocmd
local deep_merge = ____utils.deep_merge
local MAPPINGS = {
    ["lsp.formatting"] = {
        cmd = function() return vim.lsp.buf.formatting() end,
        desc = "Formatting"
    },
    ["lsp.goto_declaration"] = {
        cmd = function() return vim.lsp.buf.declaration() end,
        desc = "Goto declaration"
    },
    ["lsp.goto_definition"] = {
        cmd = function() return vim.lsp.buf.definition() end,
        desc = "Goto definition"
    },
    ["lsp.goto_next_diagnostic"] = {
        cmd = function() return vim.diagnostic.goto_next() end,
        desc = "Goto next diagnostic"
    },
    ["lsp.goto_next_error"] = {
        cmd = function() return vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR}) end,
        desc = "Goto next error"
    },
    ["lsp.goto_prev_diagnostic"] = {
        cmd = function() return vim.diagnostic.goto_prev() end,
        desc = "Goto prev diagnostic"
    },
    ["lsp.goto_prev_error"] = {
        cmd = function() return vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR}) end,
        desc = "Goto prev error"
    },
    ["lsp.hover"] = {
        cmd = function() return vim.lsp.buf.hover() end,
        desc = "Hover"
    },
    ["lsp.rename"] = {
        cmd = function() return vim.lsp.buf.rename() end,
        desc = "Rename"
    },
    ["lsp.show_code_action"] = {
        cmd = function() return vim.lsp.buf.code_action() end,
        desc = "Show code action"
    },
    ["lsp.show_diagnostic"] = {
        cmd = function() return vim.diagnostic.open_float() end,
        desc = "Show diagnostic"
    },
    ["lsp.show_document_diagnostics"] = {
        cmd = function() return vim.diagnostic.setloclist() end,
        desc = "Show document diagnostics"
    },
    ["lsp.show_implementation"] = {
        cmd = function() return vim.lsp.buf.implementation() end,
        desc = "Show implementation"
    },
    ["lsp.show_references"] = {
        cmd = function() return vim.lsp.buf.references() end,
        desc = "Show references"
    },
    ["lsp.show_signature_help"] = {
        cmd = function() return vim.lsp.buf.signature_help() end,
        desc = "Show signature help"
    },
    ["lsp.show_workspace_diagnostics"] = {
        cmd = function() return vim.diagnostic.setqflist() end,
        desc = "Show workspace diagnostics"
    }
}
local function on_attach(client, buffer)
    if client.resolved_capabilities.document_highlight == true then
        autocmd(
            "CursorHold,CursorHoldI",
            function() return vim.lsp.buf.document_highlight() end,
            {buffer = buffer}
        )
        autocmd(
            "CursorMoved,CursorMovedI,InsertEnter",
            function() return vim.lsp.buf.clear_references() end,
            {buffer = buffer}
        )
    end
    apply_mappings(MAPPINGS, {buffer = buffer})
    apply_extra("lsp.extra", {mode = "n", buffer = buffer})
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
                        conf.on_attach(client, buffer)
                    end
                end,
                capabilities = capabilities
            },
            preset.server_default
        )
        require("lspconfig")[name].setup(opts)
    end
    local border = preset.border
    local open_floating_preview = vim.lsp.util.open_floating_preview
    vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
        opts = opts or ({})
        opts.border = border == nil and opts.border or border
        return open_floating_preview(contents, syntax, opts, ...)
    end
    require("lspconfig.ui.windows").default_options.border = border
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
