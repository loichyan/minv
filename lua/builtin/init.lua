local M = {}

function M.preset()
  return {
    tokyonight = {
      enable = true,
      style = "night",
    },
    packer = {
      display = {
        open_fn = function()
          return require("packer.util").float({ border = "rounded" })
        end,
      },
    },
    which_key = require("builtin.which_key").preset(),
    gitsigns = require("builtin.gitsigns").preset(),
    treesitter = require("builtin.treesitter").preset(),
    comment = {
      sticky = true,
      padding = true,
    },
    lsp = require("builtin.lsp").preset(),
    lspconfig = {
      flags = {
        debounce_text_changes = 250,
      },
    },
    null_ls = {
      debounce = 250,
    },
    lsp_installer = {},
    cmp = require("builtin.cmp").preset(),
    luasnip = {
      history = false,
    },
    telescope = require("builtin.telescope").preset(),
    toggleterm = require("builtin.toggleterm").preset(),
    tree = require("builtin.tree").preset(),
    bufferline = require("builtin.bufferline").preset(),
    lualine = require("builtin.lualine").preset(),
    dashboard = require("builtin.alpha").preset(),
  }
end

---@param minv MiNV
function M.setup(minv)
  M._MINV = minv

  -- Set colorscheme.
  local tokyonight = minv.builtin.tokyonight
  if tokyonight.enable then
    vim.g.tokyonight_style = tokyonight.style
    pcall(vim.cmd, "colorscheme tokyonight")
  end

  -- Setup which-key.
  if minv.builtin.which_key.enable then
    require("builtin.which_key").setup(minv)
  end

  return {
    -----------
    -- Basic --
    -----------
    -- Deps
    { "nvim-lua/plenary.nvim" },
    { "kyazdani42/nvim-web-devicons" },
    -- Theme
    { "folke/tokyonight.nvim" },
    -- Keybinding
    { "folke/which-key.nvim" },
    ---------
    -- Git --
    ---------
    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("builtin.gitsigns").setup(require("builtin")._MINV)
      end,
    },
    ----------------
    -- Treesitter --
    ----------------
    {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("builtin.treesitter").setup(require("builtin")._MINV)
      end,
    },
    -- Comments
    {
      "numToStr/Comment.nvim",
      config = function()
        require("builtin.comment").setup(require("builtin")._MINV)
      end,
    },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    ---------
    -- LSP --
    ---------
    {
      "neovim/nvim-lspconfig",
      config = function()
        require("builtin.lsp").setup(require("builtin")._MINV)
      end,
    },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "williamboman/nvim-lsp-installer" },
    ----------------
    -- Completion --
    ----------------
    {
      "hrsh7th/nvim-cmp",
      config = function()
        require("builtin.cmp").setup(require("builtin")._MINV)
      end,
    },
    -- Completion sources
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-buffer" },
    -- Snippets
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },
    ---------------
    -- Telescope --
    ---------------
    {
      "nvim-telescope/telescope.nvim",
      config = function()
        require("builtin.telescope").setup(require("builtin")._MINV)
      end,
    },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    --------
    -- UI --
    --------
    {
      "akinsho/toggleterm.nvim",
      config = function()
        require("builtin.toggleterm").setup(require("builtin")._MINV)
      end,
    },
    {
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("builtin.tree").setup(require("builtin")._MINV)
      end,
    },
    {
      "akinsho/bufferline.nvim",
      config = function()
        require("builtin.bufferline").setup(require("builtin")._MINV)
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      config = function()
        require("builtin.lualine").setup(require("builtin")._MINV)
      end,
    },
    {
      "goolord/alpha-nvim",
      config = function()
        require("builtin.alpha").setup(require("builtin")._MINV)
      end,
    },
  }
end

return M
