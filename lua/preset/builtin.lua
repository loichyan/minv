local M = {}

function M.preset()
  ---@class MiNVBuiltin
  local preset = {
    treesitter = require("plugins.treesitter").preset(),
    cmp = require("plugins.cmp").preset(),
    lsp = require("plugins.lsp").preset(),
    comment = require("plugins.comment").preset(),
    telescope = require("plugins.telescope").preset(),
    gitsigns = require("plugins.gitsigns").preset(),
    bufferline = require("plugins.bufferline").preset(),
    lualine = require("plugins.lualine").preset(),
    tree = require("plugins.tree").preset(),
    term = require("plugins.term").preset(),
    tokyonight = require("plugins.tokyonight").preset(),
  }
  return preset
end

return M
