---@class MiNVBuiltin
local M = {
  lsp = require("plugins.lsp").preset(),
  cmp = require("plugins.cmp").preset(),
  treesitter = require("plugins.treesitter").preset(),
  comment = require("plugins.comment").preset(),
  buffer = require("plugins.buffer").preset(),
  lualine = require("plugins.lualine").preset(),
}

return M
