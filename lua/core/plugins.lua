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
    ---------
    -- LSP --
    ---------
    use({ "neovim/nvim-lspconfig" })
    use({ "jose-elias-alvarez/null-ls.nvim", after = "nvim-lspconfig" })
    ----------------
    -- Completion -
    ----------------
    use({ "L3MON4D3/LuaSnip" })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-nvim-lua" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-path" })
    use({
      "hrsh7th/nvim-cmp",
      after = {
        "nvim-lspconfig",
        "LuaSnip",
        "cmp-nvim-lsp",
        "cmp-nvim-lua",
        "cmp-buffer",
        "cmp-path",
      },
      config = function()
        require("plugins.cmp").setup(require("cmp"), require("luasnip"), _MINV.builtin.cmp)
      end,
    })
    -------------------
    -- LSP Installer --
    -------------------
    use({
      "williamboman/nvim-lsp-installer",
      after = { "null-ls.nvim", "nvim-cmp" },
      config = function()
        require("plugins.lsp").setup(
          require("lspconfig"),
          require("null-ls"),
          require("cmp_nvim_lsp"),
          require("nvim-lsp-installer"),
          _MINV.builtin.lsp
        )
      end,
    })
    -----------------
    -- Tree Sitter --
    -----------------
    local ts = builtin.treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      event = "BufEnter",
      config = function()
        require("plugins.treesitter").setup(require("nvim-treesitter.configs"), _MINV.builtin.treesitter)
      end,
    })
    use({
      "andymass/vim-matchup",
      disable = not ts.setup.matchup.enable,
      after = "nvim-treesitter",
    })
    use({
      "p00f/nvim-ts-rainbow",
      disable = not ts.setup.rainbow.enable,
      after = "nvim-treesitter",
    })
    -------------
    -- Comment --
    -------------
    use({
      "numToStr/Comment.nvim",
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
