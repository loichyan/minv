local M = {}

function M.preset()
  ---@class MiNVBuiltin
  local preset = {
    treesitter = require("plugins.treesitter").preset(),
    cmp = require("plugins.cmp").preset(),
    lsp = require("plugins.lsp").preset(),
    comment = require("plugins.comment").preset(),
    telescope = require("plugins.telescope").preset(),
    alpha = require("plugins.alpha").preset(),
    gitsigns = require("plugins.gitsigns").preset(),
    bufferline = require("plugins.bufferline").preset(),
    lualine = require("plugins.lualine").preset(),
    tree = require("plugins.tree").preset(),
    toggleterm = require("plugins.toggleterm").preset(),
    ui = require("plugins.ui").preset(),
  }
  return preset
end

return M
