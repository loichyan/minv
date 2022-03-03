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
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("plugins.gitsigns").setup(_MINV.builtin.gitsigns)
        pcall(_MINV.builtin.gitsigns.after)
      end,
    })
    -----------------
    -- Tree Sitter --
    -----------------
    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("plugins.treesitter").setup(_MINV.builtin.treesitter)
        pcall(_MINV.builtin.treesitter.after)
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
        pcall(_MINV.builtin.lsp.after)
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
        pcall(_MINV.builtin.cmp.after)
      end,
    })
    -- Completion sources
    local cmp = builtin.cmp
    use({
      "saadparwaiz1/cmp_luasnip",
      disable = cmp.sources["luasnip"] == 0,
      requires = "hrsh7th/nvim-cmp",
    })
    use({
      "hrsh7th/cmp-nvim-lsp",
      disable = cmp.sources["nvim_lsp"] == 0,
      requires = "hrsh7th/nvim-cmp",
    })
    use({
      "hrsh7th/cmp-path",
      disable = cmp.sources["path"] == 0,
      requires = "hrsh7th/nvim-cmp",
    })
    use({
      "hrsh7th/cmp-buffer",
      disable = cmp.sources["buffer"] == 0,
      requires = "hrsh7th/nvim-cmp",
    })
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
        pcall(_MINV.builtin.telescope.after)
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
        pcall(_MINV.builtin.alpha.after)
      end,
    })
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("plugins.lualine").setup(_MINV.builtin.lualine)
        pcall(_MINV.builtin.lualine.after)
      end,
    })
    use({
      "akinsho/bufferline.nvim",
      config = function()
        require("plugins.bufferline").setup(_MINV.builtin.bufferline)
        pcall(_MINV.builtin.bufferline.after)
      end,
    })
    use({
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("plugins.tree").setup(_MINV.builtin.tree)
        pcall(_MINV.builtin.tree.after)
      end,
    })
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("plugins.toggleterm").setup(_MINV.builtin.toggleterm)
        pcall(_MINV.builtin.toggleterm.after)
      end,
    })
    use({
      "folke/tokyonight.nvim",
      config = function()
        require("plugins.tokyonight").setup(_MINV.builtin.tokyonight)
        pcall(_MINV.builtin.tokyonight.after)
      end,
    })
    use({
      "folke/todo-comments.nvim",
      disable = not builtin.todo_comments.enable,
      config = function()
        require("plugins.todo_comments").setup(_MINV.builtin.todo_comments)
        pcall(_MINV.builtin.todo_comments.after)
      end,
    })
    use({
      "rcarriga/nvim-notify",
      disable = not builtin.notify.enable,
      config = function()
        require("plugins.notify").setup(_MINV.builtin.notify)
        pcall(_MINV.builtin.notify.after)
      end,
    })
    use({
      "j-hui/fidget.nvim",
      disable = not builtin.fidget.enable,
      config = function()
        require("plugins.fidget").setup(_MINV.builtin.fidget)
        pcall(_MINV.builtin.fidget.after)
      end,
    })
    ----------
    -- Misc --
    ----------
    -- Comments
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("plugins.comments").setup(_MINV.builtin.comments)
        pcall(_MINV.builtin.comments.after)
      end,
    })
    -- Faster filetypes.
    use({ "nathom/filetype.nvim", disable = not builtin.filetype.enable })
    -- Auto adjusts `shiftwidth` and `expandtab`
    use({ "tpope/vim-sleuth", disable = not builtin.sleuth.enable })
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
