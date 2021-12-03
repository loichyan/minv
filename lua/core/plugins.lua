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
    use({ "andymass/vim-matchup", disable = not ts.modules.matchup.enable })
    use({ "p00f/nvim-ts-rainbow", disable = not ts.modules.rainbow.enable })
    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("plugins.treesitter").setup(
          _MINV.builtin.treesitter,
          require("nvim-treesitter.configs")
        )
      end,
    })
    ---------------
    -- Autopairs --
    ---------------
    use({ "windwp/nvim-autopairs" })
    ---------
    -- LSP --
    ---------
    use({ "neovim/nvim-lspconfig" })
    use({ "jose-elias-alvarez/null-ls.nvim" })
    -------------
    -- Snippet --
    -------------
    use({ "L3MON4D3/LuaSnip" })
    ----------------
    -- Completion --
    ----------------
    use({ "saadparwaiz1/cmp_luasnip" })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-nvim-lua" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-path" })
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
    -------------------
    -- LSP Installer --
    -------------------
    use({
      "williamboman/nvim-lsp-installer",
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
    --------
    -- UI --
    --------
    use({
      "romgrk/barbar.nvim",
      config = function()
        require("plugins.buffer").setup(_MINV.builtin.buffer)
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
