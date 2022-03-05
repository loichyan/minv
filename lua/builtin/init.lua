local M = {}

function M.preset()
  ---@class MiNVBuiltin
  local preset = {
    packer = require("core.packer").preset(),
    treesitter = require("builtin.treesitter").preset(),
    cmp = require("builtin.cmp").preset(),
    lsp = require("builtin.lsp").preset(),
    telescope = require("builtin.telescope").preset(),
    alpha = require("builtin.alpha").preset(),
    bufferline = require("builtin.bufferline").preset(),
    lualine = require("builtin.lualine").preset(),
    tree = require("builtin.tree").preset(),
    toggleterm = require("builtin.toggleterm").preset(),
    tokyonight = require("builtin.tokyonight").preset(),
    gitsigns = require("builtin.gitsigns").preset(),
  }
  return preset
end

---@param preset MiNVBuiltin
function M.setup(preset)
  local ts_modules = preset.treesitter.modules
  local cmp_sources = preset.cmp.sources
  return {
    ----------
    -- Deps --
    ----------
    { "nvim-lua/plenary.nvim" },
    { "kyazdani42/nvim-web-devicons" },
    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("builtin.gitsigns").setup(_MINV.builtin.gitsigns)
        _MINV.builtin.gitsigns.after:apply()
      end,
    },
    -----------------
    -- Tree Sitter --
    -----------------
    {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("builtin.treesitter").setup(_MINV.builtin.treesitter)
        _MINV.builtin.treesitter.after:apply()
      end,
    },
    {
      "andymass/vim-matchup",
      requires = "nvim-treesitter/nvim-treesitter",
      disable = not ts_modules.matchup.enable,
    },
    -- Comments
    {
      "numToStr/Comment.nvim",
      requires = "JoosepAlviste/nvim-ts-context-commentstring",
    },
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      requires = "nvim-treesitter/nvim-treesitter",
    },
    ---------
    -- LSP --
    ---------
    {
      "neovim/nvim-lspconfig",
      requires = {
        "jose-elias-alvarez/null-ls.nvim",
        "williamboman/nvim-lsp-installer",
        "folke/trouble.nvim",
        "folke/lua-dev.nvim",
      },
      config = function()
        require("builtin.lsp").setup(_MINV.builtin.lsp)
        _MINV.builtin.lsp.after:apply()
      end,
    },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "williamboman/nvim-lsp-installer" },
    { "folke/lua-dev.nvim" },
    ----------------
    -- Completion --
    ----------------
    {
      "hrsh7th/nvim-cmp",
      requires = { "L3MON4D3/LuaSnip" },
      config = function()
        require("builtin.cmp").setup(_MINV.builtin.cmp)
        _MINV.builtin.cmp.after:apply()
      end,
    },
    -- Completion sources
    {
      "saadparwaiz1/cmp_luasnip",
      disable = not cmp_sources:has("luasnip"),
      requires = "hrsh7th/nvim-cmp",
    },
    {
      "hrsh7th/cmp-nvim-lsp",
      disable = not cmp_sources:has("nvim_lsp"),
      requires = "hrsh7th/nvim-cmp",
    },
    {
      "hrsh7th/cmp-path",
      disable = not cmp_sources:has("path"),
      requires = "hrsh7th/nvim-cmp",
    },
    {
      "hrsh7th/cmp-buffer",
      disable = not cmp_sources:has("buffer"),
      requires = "hrsh7th/nvim-cmp",
    },
    -- Snippets
    {
      "L3MON4D3/LuaSnip",
      requires = "rafamadriz/friendly-snippets",
    },
    { "rafamadriz/friendly-snippets" },
    ---------------
    -- Telescope --
    ---------------
    {
      "nvim-telescope/telescope.nvim",
      requires = { "nvim-telescope/telescope-fzf-native.nvim", "rcarriga/nvim-notify" },
      config = function()
        require("builtin.telescope").setup(_MINV.builtin.telescope)
        _MINV.builtin.telescope.after:apply()
      end,
    },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    --------
    -- UI --
    --------
    {
      "goolord/alpha-nvim",
      config = function()
        require("builtin.alpha").setup(_MINV.builtin.alpha)
        _MINV.builtin.alpha.after:apply()
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      config = function()
        require("builtin.lualine").setup(_MINV.builtin.lualine)
        _MINV.builtin.lualine.after:apply()
      end,
    },
    {
      "akinsho/bufferline.nvim",
      config = function()
        require("builtin.bufferline").setup(_MINV.builtin.bufferline)
        _MINV.builtin.bufferline.after:apply()
      end,
    },
    {
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("builtin.tree").setup(_MINV.builtin.tree)
        _MINV.builtin.tree.after:apply()
      end,
    },
    {
      "akinsho/toggleterm.nvim",
      config = function()
        require("builtin.toggleterm").setup(_MINV.builtin.toggleterm)
        _MINV.builtin.toggleterm.after:apply()
      end,
    },
    {
      "folke/tokyonight.nvim",
      config = function()
        require("builtin.tokyonight").setup(_MINV.builtin.tokyonight)
        _MINV.builtin.tokyonight.after:apply()
      end,
    },
  }
end

return M
