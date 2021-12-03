local M = {}

---@param builtin MiNVBuiltin
---@param extra table[]|nil
function M.setup(builtin, extra)
  local packer = require("core.packer")
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
    local ts = builtin.treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      event = "BufEnter",
      config = function()
        require("plugins.treesitter").setup(
          _MINV.builtin.treesitter,
          require("nvim-treesitter.configs")
        )
      end,
    })
    use({
      "andymass/vim-matchup",
      disable = not ts.modules.matchup.enable,
      after = "nvim-treesitter",
    })
    use({
      "p00f/nvim-ts-rainbow",
      disable = not ts.modules.rainbow.enable,
      after = "nvim-treesitter",
    })
    ---------------
    -- Autopairs --
    ---------------
    use({ "windwp/nvim-autopairs", after = "nvim-treesitter" })
    ---------
    -- LSP --
    ---------
    use({ "neovim/nvim-lspconfig" })
    use({ "jose-elias-alvarez/null-ls.nvim", after = "nvim-lspconfig" })
    ----------------
    -- Completion --
    ----------------
    use({ "L3MON4D3/LuaSnip" })
    use({
      "hrsh7th/nvim-cmp",
      after = { "LuaSnip", "nvim-autopairs" },
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
    use({ "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } })
    use({ "hrsh7th/cmp-nvim-lsp", after = { "nvim-cmp", "nvim-lspconfig" } })
    use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
    -------------------
    -- LSP Installer --
    -------------------
    use({
      "williamboman/nvim-lsp-installer",
      after = { "nvim-lspconfig", "null-ls.nvim", "cmp-nvim-lsp" },
      config = function()
        require("plugins.lsp").setup(
          _MINV.builtin.lsp,
          require("lspconfig"),
          require("null-ls"),
          require("cmp_nvim_lsp"),
          require("nvim-lsp-installer")
        )
      end,
    })
    -------------
    -- Comment --
    -------------
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("plugins.comment").setup(_MINV.builtin.comment, require("Comment"))
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
        require("plugins.lualine").setup(_MINV.builtin.lualine, require("lualine"))
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
