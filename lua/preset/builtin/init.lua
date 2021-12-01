---@class MiNVBuiltin
local M = {
  packer = {
    init = require("preset.builtin.packer").init,
  },
  treesitter = {
    setup = require("preset.builtin.treesitter").setup,
  },
  buffer = {
    keymaps = require("preset.builtin.buffer").keymaps,
  },
  lualine = {
    setup = {},
  },
}

return M
