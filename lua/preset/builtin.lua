local M = {}

function M.preset()
  ---@class MiNVBuiltin
  local preset = {
    packer = require("core.packer").preset(),
    treesitter = require("plugins.treesitter").preset(),
    cmp = require("plugins.cmp").preset(),
    lsp = require("plugins.lsp").preset(),
    telescope = require("plugins.telescope").preset(),
    alpha = require("plugins.alpha").preset(),
    bufferline = require("plugins.bufferline").preset(),
    lualine = require("plugins.lualine").preset(),
    tree = require("plugins.tree").preset(),
    toggleterm = require("plugins.toggleterm").preset(),
    tokyonight = require("plugins.tokyonight").preset(),
    gitsigns = require("plugins.gitsigns").preset(),
    comments = require("plugins.comments").preset(),
  }
  return preset
end

return M
