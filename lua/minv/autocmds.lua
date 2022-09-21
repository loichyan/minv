--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____utils = require("minv.utils")
local autocmd = ____utils.autocmd
____exports.AUTOCMDS = {
    hl_yank = {enable = true, pat = "*", highgroup = "Search", timeout = 200},
    format_on_save = {enable = true, pat = "*", timeout = nil},
    close = {enable = true, key = "q", ft = {
        "vim",
        "help",
        "man",
        "git",
        "qf",
        "lspinfo",
        "TelescopePrompt",
        "null-ls-info"
    }},
    trim_spaces = {enable = true, pat = "*"},
    auto_resize = {enable = true, pat = "*"}
}
local ARGS = {
    hl_yank = function(____bindingPattern0)
        local timeout
        local highgroup
        local pat
        pat = ____bindingPattern0.pat
        highgroup = ____bindingPattern0.highgroup
        timeout = ____bindingPattern0.timeout
        return {
            "TextYankPost",
            pat,
            function()
                require("vim.highlight").on_yank({highgroup = highgroup, timeout = timeout})
            end
        }
    end,
    format_on_save = function(____bindingPattern0)
        local timeout
        local pat
        pat = ____bindingPattern0.pat
        timeout = ____bindingPattern0.timeout
        return {
            "BufWritePre",
            pat,
            function()
                vim.lsp.buf.formatting_sync(nil, timeout)
            end
        }
    end,
    close = function(____bindingPattern0)
        local ft
        local key
        key = ____bindingPattern0.key
        ft = ____bindingPattern0.ft
        return {
            "FileType",
            ft,
            function(____bindingPattern0)
                local buf
                buf = ____bindingPattern0.buf
                vim.api.nvim_buf_set_keymap(
                    buf,
                    "",
                    key,
                    "close!",
                    {silent = true, noremap = true}
                )
            end
        }
    end,
    trim_spaces = function(____bindingPattern0)
        local pat
        pat = ____bindingPattern0.pat
        return {"BufWritePre", pat, "silent s/s+$//e"}
    end,
    auto_resize = function(____bindingPattern0)
        local pat
        pat = ____bindingPattern0.pat
        return {"VimResized", pat, "wincmd ="}
    end
}
function ____exports.setup()
    for name, opts in pairs(____exports.AUTOCMDS) do
        if opts.enable then
            local event, pat, cmd, o = unpack(ARGS[name](opts))
            autocmd(event, pat, cmd, o)
        end
    end
end
return ____exports
