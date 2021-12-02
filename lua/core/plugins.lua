local M = {}

---@param builtin MiNVBuiltin
---@param extra table[]|nil
function M.setup(builtin, extra)
  local packer = require("core.packer")
  packer.init(builtin.packer.init)
  -- Load plugins.
  -- TODO: move configs to files
  packer.startup(function(use)
    ------------
    -- Packer --
    ------------
    use({
      "wbthomason/packer.nvim",
    })
    ----------
    -- Deps --
    ----------
    use({
      "kyazdani42/nvim-web-devicons",
    })
    ---------
    -- LSP --
    ---------
    use({
      "neovim/nvim-lspconfig",
    })
    use({
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
    })
    use({
      "williamboman/nvim-lsp-installer",
      after = "nvim-lspconfig",
    })
    -----------------
    -- Tree Sitter --
    -----------------
    use({
      "nvim-treesitter/nvim-treesitter",
      event = "BufEnter",
      config = function()
        require("nvim-treesitter").setup(_MINV.builtin.treesitter.setup)
      end,
    })
    use({
      "andymass/vim-matchup",
      after = "nvim-treesitter",
    })
    use({
      "p00f/nvim-ts-rainbow",
      after = "nvim-treesitter",
    })
    use({
      "JoosepAlviste/nvim-ts-context-commentstring",
      after = "nvim-treesitter",
    })
    -------------
    -- Comment --
    -------------
    use({
      "numToStr/Comment.nvim",
      after = "nvim-treesitter",
      config = function()
        require("Comment").setup({
          toggler = {
            line = "<Plug>CommentToggleLine",
            block = "<Plug>CommentToggleBlock",
          },
          opleader = {
            line = "<Plug>CommentOpLine",
            block = "<Plug>CommentOpBlock",
          },
          mappings = {
            basic = true,
            extra = false,
            extended = false,
          },
        })
        local utils = require("utils")
        local keymaps = _MINV.builtin.comment.keymaps
        utils.map("n", keymaps.toggle_line, "<Plug>CommentToggleLine", { noremap = false })
        utils.map("n", keymaps.toggle_block, "<Plug>CommentToggleBlock", { noremap = false })
        utils.map({ "n", "x" }, keymaps.op_line, "<Plug>CommentOpLine", { noremap = false })
        utils.map({ "n", "x" }, keymaps.op_block, "<Plug>CommentOpBlock", { noremap = false })
      end,
    })
    ------------
    -- Buffer --
    ------------
    use({
      "romgrk/barbar.nvim",
      config = function()
        local utils = require("utils")
        local keymaps = _MINV.builtin.buffer.keymaps
        utils.map("n", keymaps.next, ":BufferNext<CR>")
        utils.map("n", keymaps.previous, ":BufferPrevious<CR>")
      end,
    })
    -------------
    -- Lualine --
    -------------
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("lualine").setup(_MINV.builtin.lualine.setup)
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
