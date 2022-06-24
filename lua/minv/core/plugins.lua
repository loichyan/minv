local M = {}

function M.preset()
  local group = require("minv.utils").PluginGroup
  return {
    essential = {
      plug = group({
        -- Packer
        { "wbthomason/packer.nvim" },
        -- Speed up startup time.
        { "lewis6991/impatient.nvim" },
        -- Used by many plugins.
        { "nvim-lua/plenary.nvim" },
      }),
      packer = {
        display = {
          open_fn = function()
            return require("packer.util").float({ border = "rounded" })
          end,
        },
      },
    },
    theme = {
      plug = group({
        { "folke/tokyonight.nvim" },
      }),
      tokyonight = { style = "night" },
      -- Setup function runs before other plugins.
      setup = function()
        vim.g.tokyonight_style = _MINV.plugins.theme.tokyonight.style
        vim.cmd("colorscheme tokyonight")
      end,
    },
    treesitter = {
      plug = group({
        {
          "nvim-treesitter/nvim-treesitter",
          config = function()
            require("minv.builtin.treesitter").setup(_MINV)
          end,
        },
        {
          "numToStr/Comment.nvim",
          config = function()
            require("minv.builtin.comment").setup(_MINV)
          end,
        },
        { "JoosepAlviste/nvim-ts-context-commentstring" },
      }),
      config = require("minv.builtin.treesitter").preset(),
      comment = { sticky = true, padding = true },
    },
    lsp = {
      plug = group({
        {
          "neovim/nvim-lspconfig",
          config = function()
            require("minv.builtin.lsp").setup(_MINV)
          end,
        },
        { "jose-elias-alvarez/null-ls.nvim" },
        { "williamboman/nvim-lsp-installer" },
      }),
      config = require("minv.builtin.lsp").preset(),
      installer = {
        ---Servers to be installed.
        ensure_installed = { "sumneko_lua" },
        automatic_installation = false,
      },
      null_ls = { debounce = 250 },
    },
    cmp = {
      plug = group({
        {
          "hrsh7th/nvim-cmp",
          config = function()
            require("minv.builtin.cmp").setup(_MINV)
          end,
        },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-buffer" },
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },
      }),
      config = require("minv.builtin.cmp").preset(),
      luasnip = { history = false },
    },
    telescope = {
      plug = group({
        {
          "nvim-telescope/telescope.nvim",
          config = function()
            require("minv.builtin.telescope").setup(_MINV)
          end,
        },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      }),
      config = require("minv.builtin.telescope").preset(),
    },
    ui = {
      plug = group({
        -- Used by many UI plugins.
        { "kyazdani42/nvim-web-devicons" },
        {
          "folke/which-key.nvim",
          config = function()
            require("minv.builtin.which_key").setup(_MINV)
          end,
        },
        {
          "lewis6991/gitsigns.nvim",
          config = function()
            require("minv.builtin.gitsigns").setup(_MINV)
          end,
        },
        {
          "akinsho/bufferline.nvim",
          config = function()
            require("minv.builtin.bufferline").setup(_MINV)
          end,
        },
        {
          "nvim-lualine/lualine.nvim",
          config = function()
            require("minv.builtin.lualine").setup(_MINV)
          end,
        },
        {
          "kyazdani42/nvim-tree.lua",
          config = function()
            require("minv.builtin.tree").setup(_MINV)
          end,
        },
        {
          "akinsho/toggleterm.nvim",
          config = function()
            require("minv.builtin.toggleterm").setup(_MINV)
          end,
        },
        {
          "goolord/alpha-nvim",
          config = function()
            require("minv.builtin.alpha").setup(_MINV)
          end,
        },
      }),
      which_key = require("minv.builtin.which_key").preset(),
      gitsigns = require("minv.builtin.gitsigns").preset(),
      bufferline = require("minv.builtin.bufferline").preset(),
      lualine = require("minv.builtin.lualine").preset(),
      tree = require("minv.builtin.tree").preset(),
      toggleterm = require("minv.builtin.toggleterm").preset(),
      dashboard = require("minv.builtin.alpha").preset(),
    },
    extra = group(),
  }
end

---@param minv MiNV
function M.setup(minv)
  local preset = minv.plugins
  preset.theme.setup()
  -- Setup packer.
  require("minv.core.packer").setup({
    function(use)
      -- Load plugins.
      for _, group in ipairs({
        preset.essential.plug,
        preset.theme.plug,
        preset.treesitter.plug,
        preset.lsp.plug,
        preset.cmp.plug,
        preset.telescope.plug,
        preset.ui.plug,
        preset.extra,
      }) do
        for _, plug in ipairs(group:to_plugins()) do
          use(plug)
        end
      end
    end,
    config = preset.essential.packer,
  })
end

return M
