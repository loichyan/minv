local M = {}

---@param builtin MiNVBuiltin
---@param extra table[]|nil
function M.setup(packer, builtin, extra)
  -- Load plugins.
  packer.startup(function(use)
    ------------
    -- Packer --
    ------------
    use({ "wbthomason/packer.nvim" })
    ----------
    -- Deps --
    ----------
    use({ "nvim-lua/plenary.nvim" })
    use({ "kyazdani42/nvim-web-devicons" })
    -----------------
    -- Tree Sitter --
    -----------------
    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("plugins.treesitter").setup(
          _MINV.builtin.treesitter,
          require("nvim-treesitter.configs")
        )
      end,
    })
    local ts = builtin.treesitter
    use({ "andymass/vim-matchup", disable = not ts.modules.matchup.enable })
    use({ "p00f/nvim-ts-rainbow", disable = not ts.modules.rainbow.enable })
    ---------
    -- LSP --
    ---------
    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("plugins.lsp").setup(
          _MINV.builtin.lsp,
          require("lspconfig"),
          require("null-ls"),
          require("cmp_nvim_lsp"),
          require("nvim-lsp-installer"),
          require("trouble")
        )
      end,
    })
    use({ "jose-elias-alvarez/null-ls.nvim" })
    use({ "williamboman/nvim-lsp-installer" })
    use({ "folke/trouble.nvim" })
    ----------------
    -- Completion --
    ----------------
    use({ "L3MON4D3/LuaSnip" })
    use({ "windwp/nvim-autopairs" })
    use({
      "hrsh7th/nvim-cmp",
      config = function()
        require("plugins.cmp").setup(
          _MINV.builtin.cmp,
          require("luasnip"),
          require("nvim-autopairs"),
          require("nvim-autopairs.completion.cmp"),
          require("cmp")
        )
      end,
    })
    use({ "saadparwaiz1/cmp_luasnip" })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-nvim-lua" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-path" })
    -------------
    -- Comment --
    -------------
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("plugins.comment").setup(_MINV.builtin.comment, require("Comment"))
      end,
    })
    ---------------
    -- Telescope --
    ---------------
    use({
      "nvim-telescope/telescope.nvim",
      config = function()
        require("plugins.telescope").setup(_MINV.builtin.telescope, require("telescope"))
      end,
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    --------
    -- UI --
    --------
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("plugins.gitsigns").setup(_MINV.builtin.gitsigns, require("gitsigns"))
      end,
    })
    use({
      "akinsho/bufferline.nvim",
      config = function()
        require("plugins.bufferline").setup(_MINV.builtin.bufferline, require("bufferline"))
      end,
    })
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("plugins.lualine").setup(_MINV.builtin.lualine, require("lualine"))
      end,
    })
    use({
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("plugins.tree").setup(_MINV.builtin.tree, require("nvim-tree"))
      end,
    })
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("plugins.term").setup(_MINV.builtin.term, require("toggleterm"))
      end,
    })
    use({
      "folke/tokyonight.nvim",
      config = function()
        require("plugins.tokyonight").setup(_MINV.builtin.tokyonight)
      end,
    })
    ----------
    -- Misc --
    ----------
    -- Auto adjusts `shiftwidth` and `expandtab`
    use({ "tpope/vim-sleuth" })
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
