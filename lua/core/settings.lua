local M = {}

---@param settings MiNVSettings
function M.setup(settings)
  local utils = require("utils")
  utils.g({
    -- Leader
    mapleader = settings.leader,
  })
  utils.o({
    -- General
    clipboard = settings.clipboard,
    mouse = settings.mouse,
    timeoutlen = settings.timeoutlen,
    -- UI
    hidden = settings.hidden,
    signcolumn = settings.signcolumn,
    termguicolors = settings.termguicolors,
    -- Space
    expandtab = settings.expandtab,
    tabstop = settings.tabstop,
    shiftwidth = settings.shiftwidth,
    smartindent = settings.smartindent,
    -- Window
    splitbelow = settings.splitbelow,
    splitright = settings.splitright,
    -- Search
    hlsearch = settings.hlsearch,
    ignorecase = settings.ignorecase,
    smartcase = settings.smartcase,
    -- File
    swapfile = settings.swapfile,
    undofile = settings.undofile,
    -- Line number
    number = settings.number,
    relativenumber = settings.relativenumber,
  })
end

return M
