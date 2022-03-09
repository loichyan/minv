local M = {}

function M.preset()
  --TODO: add more options
  ---@class MiNVBuiltin
  local preset = {
    tokyonight = {
      enable = true,
      stype = "night",
    },
    lsp = {
      ---Servers to be installed.
      install = {
        "sumneko_lua",
      },
      ---Settings passed to servers of `lsp-config`.
      servers = {},
      ---Additional `null-ls` formatters.
      formatters = {},
      ---Additional `null-ls` linters.
      linters = {},
    },
    treesitter = {
      ---Treesitters to be installed.
      install = {
        "lua",
      },
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
      },
    },
    cmp = {
      ---Sources to be loaded.
      sources = {},
      formatting = {
        ---Single letter indicating the type of completion.
        kind = {
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "ﰠ",
          Variable = "",
          Class = "ﴯ",
          Interface = "",
          Module = "",
          Property = "ﰠ",
          Unit = "塞",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "פּ",
          Event = "",
          Operator = "",
          TypeParameter = "",
        },
        ---Text displayed after `word`.
        menu = {
          luasnip = "[SNIP]",
          nvim_lsp = "[LSP]",
          path = "[PATH]",
          buffer = "[BUF]",
        },
        ---Indicates entries should not be added when same words present.
        dup = {
          ["buffer"] = true,
        },
      },
    },
    which_key = {
      operators = { ["gc"] = "Toggle line comments", ["gb"] = "Toggle block comments" },
      triggers = "auto",
      ignore_missing = false,
      groups = {
        ["<Leader>l"] = "Lsp",
        ["<Leader>f"] = "Search",
        ["<Leader>g"] = "Git",
      },
    },
    dashboard = {
      header = function()
        return {
          "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
          "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
          "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
          "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
          "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
          "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
        }
      end,
      buttons = {
        { "n", "  New Files", ":ene<CR>" },
        { "o", "  Recent Files", ":Telescope oldfiles<CR>" },
        { "f", "  Find Files", ":Telescope find_files<CR>" },
        { "w", "  Find Words", ":Telescope live_grep<CR>" },
        { "m", "  Find Bookmarks", ":Telescope marks<CR>" },
        { "h", "  Find Themes", ":Telescope colorscheme<CR>" },
        { "q", "  Quit", ":qa<CR>" },
      },
      footer = function()
        ---@diagnostic disable-next-line:undefined-global
        return string.format("Neovim loaded %d plugins  ", vim.tbl_count(packer_plugins))
      end,
    },
    bufferline = {
      offsets = {},
    },
    lualine = {
      extensions = {},
    },
    tree = {
      respect_buf_cwd = 0,
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = false,
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 500,
      },
      view = {
        auto_resize = true,
      },
      filters = {
        custom = {
          ".git",
          ".cache",
          "node_modules",
        },
      },
    },
  }
  return preset
end

---@param minv MiNV
function M.setup(minv)
  M._MINV = minv
  return {
    -----------
    -- Basic --
    -----------
    -- Deps.
    { "nvim-lua/plenary.nvim" },
    { "kyazdani42/nvim-web-devicons" },
    -- Theme.
    {
      "folke/tokyonight.nvim",
      config = function()
        local preset = require("builtin")._MINV.builtin.tokyonight
        if preset.enable then
          vim.cmd("colorscheme tokyonight")
          vim.g.tokyonight_style = minv.builtin.tokyonight.stype
        end
      end,
    },
    -- Keybinding.
    {
      "folke/which-key.nvim",
      config = function()
        require("builtin.which_key").setup(require("builtin")._MINV)
      end,
    },
    -- Git.
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
    { "numToStr/Comment.nvim" },
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
      "goolord/alpha-nvim",
      config = function()
        require("builtin.alpha").setup(require("builtin")._MINV)
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      config = function()
        require("builtin.lualine").setup(require("builtin")._MINV)
      end,
    },
    {
      "akinsho/bufferline.nvim",
      config = function()
        require("builtin.bufferline").setup(require("builtin")._MINV)
      end,
    },
    {
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("builtin.tree").setup(require("builtin")._MINV)
      end,
    },
    {
      "akinsho/toggleterm.nvim",
      config = function()
        require("builtin.toggleterm").setup(require("builtin")._MINV)
      end,
    },
  }
end

return M
