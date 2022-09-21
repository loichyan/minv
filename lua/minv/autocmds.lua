--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____utils = require("minv.utils")
local autocmd = ____utils.autocmd
____exports.AUTOCMDS = {
    hl_yank = {enable = true, pattern = "*", highgroup = "Search", timeout = 200},
    format_on_save = {enable = true, pattern = "*", timeout = nil},
    close = {enable = true, key = "q", filetype = {
        "vim",
        "help",
        "man",
        "git",
        "qf",
        "lspinfo",
        "TelescopePrompt",
        "null-ls-info"
    }},
    trim_spaces = {enable = true, pattern = "*"},
    auto_resize = {enable = true, pattern = "*"}
}
local ARGS = {
    hl_yank = function(____bindingPattern0)
        local timeout
        local highgroup
        local pattern
        pattern = ____bindingPattern0.pattern
        highgroup = ____bindingPattern0.highgroup
        timeout = ____bindingPattern0.timeout
        return {
            "TextYankPost",
            function()
                require("vim.highlight").on_yank({highgroup = highgroup, timeout = timeout})
            end,
            {pattern = pattern}
        }
    end,
    format_on_save = function(____bindingPattern0)
        local timeout
        local pattern
        pattern = ____bindingPattern0.pattern
        timeout = ____bindingPattern0.timeout
        return {
            "BufWritePre",
            function()
                vim.lsp.buf.formatting_sync(nil, timeout)
            end,
            {pattern = pattern}
        }
    end,
    close = function(____bindingPattern0)
        local filetype
        local key
        key = ____bindingPattern0.key
        filetype = ____bindingPattern0.filetype
        return {
            "FileType",
            function(____bindingPattern0)
                local buf
                buf = ____bindingPattern0.buf
                vim.api.nvim_buf_set_keymap(
                    buf,
                    "",
                    key,
                    "<Cmd>q!<CR>",
                    {silent = true, noremap = true}
                )
            end,
            {pattern = filetype}
        }
    end,
    trim_spaces = function(____bindingPattern0)
        local pattern
        pattern = ____bindingPattern0.pattern
        return {"BufWritePre", "silent s/s+$//e", {pattern = pattern}}
    end,
    auto_resize = function(____bindingPattern0)
        local pattern
        pattern = ____bindingPattern0.pattern
        return {"VimResized", "wincmd =", {pattern = pattern}}
    end
}
function ____exports.setup_autocmds()
    for name, opts in pairs(____exports.AUTOCMDS) do
        if opts.enable then
            local event, cmd, o = unpack(ARGS[name](opts))
            autocmd(event, cmd, o)
        end
    end
end
return ____exports
