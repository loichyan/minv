---@class MiNVBuiltin
local M = {
  treesitter = require("plugins.treesitter").preset(),
  cmp = require("plugins.cmp").preset(),
  lsp = require("plugins.lsp").preset(),
  comment = require("plugins.comment").preset(),
  buffer = require("plugins.buffer").preset(),
  lualine = require("plugins.lualine").preset(),
  tree = require("plugins.tree").preset(),
}

return M
