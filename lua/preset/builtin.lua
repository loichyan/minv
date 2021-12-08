---@class MiNVBuiltin
local M = {
  treesitter = require("plugins.treesitter").preset(),
  cmp = require("plugins.cmp").preset(),
  lsp = require("plugins.lsp").preset(),
  comment = require("plugins.comment").preset(),
  telescope = require("plugins.telescope").preset(),
  bufferline = require("plugins.bufferline").preset(),
  lualine = require("plugins.lualine").preset(),
  tree = require("plugins.tree").preset(),
  term = require("plugins.term").preset(),
}

return M
