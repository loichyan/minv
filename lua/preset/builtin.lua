---@class MiNVBuiltin
local M = {
  treesitter = require("plugins.treesitter").preset(),
  comment = require("plugins.comment").preset(),
  buffer = require("plugins.buffer").preset(),
  lualine = require("plugins.lualine").preset(),
}

return M
