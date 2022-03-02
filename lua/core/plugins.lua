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
        require("plugins.treesitter").setup(_MINV.builtin.treesitter)
      end,
    })
    local ts = builtin.treesitter
    use({
      "andymass/vim-matchup",
      requires = "nvim-treesitter/nvim-treesitter",
      disable = not ts.modules.matchup.enable,
    })
    use({
      "p00f/nvim-ts-rainbow",
      requires = "nvim-treesitter/nvim-treesitter",
      disable = not ts.modules.rainbow.enable,
    })
    ---------
    -- LSP --
    ---------
    use({
      "neovim/nvim-lspconfig",
      requires = {
        "jose-elias-alvarez/null-ls.nvim",
        "williamboman/nvim-lsp-installer",
        "folke/trouble.nvim",
        "folke/lua-dev.nvim",
      },
      config = function()
        require("plugins.lsp").setup(_MINV.builtin.lsp)
      end,
    })
    use({ "jose-elias-alvarez/null-ls.nvim" })
    use({ "williamboman/nvim-lsp-installer" })
    use({ "folke/trouble.nvim" })
    use({ "folke/lua-dev.nvim" })
    ----------------
    -- Completion --
    ----------------
    use({
      "hrsh7th/nvim-cmp",
      requires = { "L3MON4D3/LuaSnip" },
      config = function()
        require("plugins.cmp").setup(_MINV.builtin.cmp)
      end,
    })
    -- Completion sources
    use({ "saadparwaiz1/cmp_luasnip", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-path", requires = "hrsh7th/nvim-cmp" })
    -- Snippets
    use({
      "L3MON4D3/LuaSnip",
      requires = { "rafamadriz/friendly-snippets", "windwp/nvim-autopairs" },
    })
    use({ "rafamadriz/friendly-snippets" })
    use({ "windwp/nvim-autopairs" })
    ---------------
    -- Telescope --
    ---------------
    use({
      "nvim-telescope/telescope.nvim",
      requires = { "nvim-telescope/telescope-fzf-native.nvim", "rcarriga/nvim-notify" },
      config = function()
        require("plugins.telescope").setup(_MINV.builtin.telescope)
      end,
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    --------
    -- UI --
    --------
    use({
      "goolord/alpha-nvim",
      config = function()
        require("plugins.alpha").setup(_MINV.builtin.alpha)
      end,
    })
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("plugins.lualine").setup(_MINV.builtin.lualine)
      end,
    })
    use({
      "akinsho/bufferline.nvim",
      config = function()
        require("plugins.bufferline").setup(_MINV.builtin.bufferline)
      end,
    })
    use({
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("plugins.tree").setup(_MINV.builtin.tree)
      end,
    })
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("plugins.toggleterm").setup(_MINV.builtin.toggleterm)
      end,
    })
    use({
      "folke/tokyonight.nvim",
      config = function()
        require("plugins.tokyonight").setup(_MINV.builtin.tokyonight)
      end,
    })
    use({
      "folke/todo-comments.nvim",
      config = function()
        require("plugins.todo_comments").setup(_MINV.builtin.todo_comments)
      end,
    })
    use({
      "rcarriga/nvim-notify",
      config = function()
        require("plugins.notify").setup(_MINV.builtin.notify)
      end,
    })
    use({
      "j-hui/fidget.nvim",
      config = function()
        require("plugins.fidget").setup(_MINV.builtin.fidget)
      end,
    })
    ----------
    -- Misc --
    ----------
    -- Gitsigns
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("plugins.gitsigns").setup(_MINV.builtin.gitsigns)
      end,
    })
    -- Comments
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("plugins.comments").setup(_MINV.builtin.comments)
      end,
    })
    -- Faster filetypes.
    use({ "nathom/filetype.nvim" })
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
