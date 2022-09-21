--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
do
    local ____utils = require("spark/utils")
    local deep_merge = ____utils.deep_merge
    ____exports.deep_merge = deep_merge
end
function ____exports.plug_key(name)
    return string.format("<Plug>(minv.%s)", name)
end
function ____exports.mkHint()
    return function(u)
        return u
    end
end
function ____exports.autocmd(event, pattern, cmd, opts)
    local options = vim.tbl_extend("keep", {pattern = pattern}, opts or ({}))
    if type(cmd) == "string" then
        options.command = cmd
    elseif type(cmd) == "function" then
        options.callback = cmd
    end
    vim.api.nvim_create_autocmd(event, options)
end
return ____exports
