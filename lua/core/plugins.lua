local M = {}

---@param builtin MiNVBuiltin
---@param extra table[]|nil
function M.setup(builtin, extra)
  local packer = require("core.packer")
  require("plugins.packer").setup(packer, builtin.packer)
  -- Load plugins.
  packer.startup(function(use)
    ------------
    -- Packer --
    ------------
    use({
      "wbthomason/packer.nvim",
    })
    ----------
    -- Deps --
    ----------
    use({
      "kyazdani42/nvim-web-devicons",
    })
    ---------
    -- LSP --
    ---------
    use({
      "neovim/nvim-lspconfig",
    })
    use({
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
    })
    use({
      "williamboman/nvim-lsp-installer",
      after = "nvim-lspconfig",
    })
    -----------------
    -- Tree Sitter --
    -----------------
    use({
      "nvim-treesitter/nvim-treesitter",
      event = "BufEnter",
      config = function()
        require("plugins.treesitter").setup(require("nvim-treesitter"), _MINV.builtin.treesitter)
      end,
    })
    use({
      "andymass/vim-matchup",
      after = "nvim-treesitter",
    })
    use({
      "p00f/nvim-ts-rainbow",
      after = "nvim-treesitter",
    })
    use({
      "JoosepAlviste/nvim-ts-context-commentstring",
      after = "nvim-treesitter",
    })
    -------------
    -- Comment --
    -------------
    use({
      "numToStr/Comment.nvim",
      after = "nvim-treesitter",
      config = function()
        require("plugins.comment").setup(require("Comment"), _MINV.builtin.comment)
      end,
    })
    ------------
    -- Buffer --
    ------------
    use({
      "romgrk/barbar.nvim",
      config = function()
        require("plugins.buffer").setup(_MINV.builtin.buffer)
      end,
    })
    -------------
    -- Lualine --
    -------------
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("plugins.lualine").setup(require("lualine"), _MINV.builtin.lualine)
      end,
    })
    -------------------
    -- Extra plugins --
    -------------------
    if extra ~= nil then
      for _, plug in pairs(extra) do
        use(plug)
      end
    end
  end)
end

return M