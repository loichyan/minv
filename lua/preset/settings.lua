---@class MiNVSettings
local M = {}

---@class MiNVGlobals
M.g = {
  -- Leader
  mapleader = " ",
}

---@class MiNVOptions
M.o = {
  -- General
  clipboard = "unnamed",
  mouse = "a",
  timeoutlen = 500,
  -- UI
  hidden = true,
  title = true,
  signcolumn = "yes",
  termguicolors = true,
  -- Space
  expandtab = true,
  tabstop = 4,
  shiftwidth = 4,
  -- Window
  splitbelow = true,
  splitright = true,
  -- Search
  hlsearch = true,
  ignorecase = true,
  smartcase = true,
  smartindent = true,
  -- File
  swapfile = false,
  undofile = true,
  -- Line number
  number = true,
  relativenumber = true,
}

return M
