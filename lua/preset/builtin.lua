---@class MiNVBuiltin
local M = {
  packer = require("plugins.packer").preset(),
  treesitter = require("plugins.treesitter").preset(),
  comment = require("plugins.comment").preset(),
  buffer = require("plugins.buffer").preset(),
  lualine = require("plugins.lualine").preset(),
}

return M
