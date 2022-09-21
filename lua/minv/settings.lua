--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
____exports.SETTINGS = {g = {mapleader = " ", markdown_fenced_languages = {
    "bash",
    "c",
    "json",
    "lua",
    "python",
    "sh"
}}, o = {
    clipboard = "unnamed",
    mouse = "a",
    timeoutlen = 300,
    updatetime = 300,
    autoread = true,
    expandtab = true,
    tabstop = 4,
    shiftwidth = 4,
    autoindent = true,
    hlsearch = true,
    ignorecase = true,
    smartcase = true,
    swapfile = false,
    undofile = true,
    number = true,
    relativenumber = true,
    hidden = true,
    title = true,
    signcolumn = "yes",
    termguicolors = true,
    showmode = false,
    splitbelow = true,
    splitright = true
}}
function ____exports.setup_settings()
    for k, v in pairs(____exports.SETTINGS.g) do
        vim.g[k] = v
    end
    for k, v in pairs(____exports.SETTINGS.o) do
        vim.o[k] = v
    end
end
return ____exports
