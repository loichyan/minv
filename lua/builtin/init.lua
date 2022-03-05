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
        pcall(_MINV.builtin.gitsigns.after)
      end,
    },
    -----------------
    -- Tree Sitter --
    -----------------
    {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("builtin.treesitter").setup(_MINV.builtin.treesitter)
        pcall(_MINV.builtin.treesitter.after)
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
        pcall(_MINV.builtin.lsp.after)
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
        pcall(_MINV.builtin.cmp.after)
      end,
    },
    -- Completion sources
    {
      "saadparwaiz1/cmp_luasnip",
      disable = cmp_sources.luasnip == 0,
      requires = "hrsh7th/nvim-cmp",
    },
    {
      "hrsh7th/cmp-nvim-lsp",
      disable = cmp_sources.nvim_lsp == 0,
      requires = "hrsh7th/nvim-cmp",
    },
    {
      "hrsh7th/cmp-path",
      disable = cmp_sources.path == 0,
      requires = "hrsh7th/nvim-cmp",
    },
    {
      "hrsh7th/cmp-buffer",
      disable = cmp_sources.buffer == 0,
      requires = "hrsh7th/nvim-cmp",
    },
    {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      disable = cmp_sources.nvim_lsp_signature_help == 0,
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
        pcall(_MINV.builtin.telescope.after)
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
        pcall(_MINV.builtin.alpha.after)
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      config = function()
        require("builtin.lualine").setup(_MINV.builtin.lualine)
        pcall(_MINV.builtin.lualine.after)
      end,
    },
    {
      "akinsho/bufferline.nvim",
      config = function()
        require("builtin.bufferline").setup(_MINV.builtin.bufferline)
        pcall(_MINV.builtin.bufferline.after)
      end,
    },
    {
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("builtin.tree").setup(_MINV.builtin.tree)
        pcall(_MINV.builtin.tree.after)
      end,
    },
    {
      "akinsho/toggleterm.nvim",
      config = function()
        require("builtin.toggleterm").setup(_MINV.builtin.toggleterm)
        pcall(_MINV.builtin.toggleterm.after)
      end,
    },
    {
      "folke/tokyonight.nvim",
      config = function()
        require("builtin.tokyonight").setup(_MINV.builtin.tokyonight)
        pcall(_MINV.builtin.tokyonight.after)
      end,
    },
  }
end

return M
