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
    notify = require("plugins.notify").preset(),
    tokyonight = require("plugins.tokyonight").preset(),
    fidget = require("plugins.fidget").preset(),
    gitsigns = require("plugins.gitsigns").preset(),
    todo_comments = require("plugins.todo_comments").preset(),
    comments = require("plugins.comments").preset(),
    filetype = { enable = true },
    sleuth = { enable = true },
  }
  return preset
end

return M
