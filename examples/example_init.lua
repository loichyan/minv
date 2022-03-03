local M = {}

---@param minv MiNV
function M.setup(minv)
  -- Add extra plugins.
  minv.extra = {
    -- Pretty git diff viewer.
    {
      "sindrets/diffview.nvim",
      config = function()
        local utils = require("utils")
        local cb = require("diffview.config").diffview_callback

        require("diffview").setup({
          enhanced_diff_hl = true,
          file_panel = {
            width = 30,
          },
          key_bindings = {
            view = {
              ["q"] = "<Cmd>DiffviewClose<CR>",
              ["<C-b>"] = cb("toggle_files"),
              ["<C-n>"] = cb("focus_files"),
            },
            file_panel = {
              ["q"] = "<Cmd>DiffviewClose<CR>",
              ["o"] = cb("select_entry"),
              ["<CR>"] = cb("focus_entry"),
              ["<2-LeftMouse>"] = cb("focus_entry"),
              ["<C-b>"] = cb("toggle_files"),
              ["<C-n>"] = cb("focus_files"),
            },
            file_history_panel = {
              ["q"] = "<Cmd>DiffviewClose<CR>",
              ["o"] = cb("select_entry"),
              ["<CR>"] = cb("focus_entry"),
              ["<2-LeftMouse>"] = cb("focus_entry"),
              ["<C-b>"] = cb("toggle_files"),
              ["<C-n>"] = cb("focus_files"),
            },
          },
        })

        -- Set keymaps.
        utils.keymaps({
          { "<Leader>gg", "<Cmd>DiffviewOpen<CR>" },
        })
      end,
    },
    -- Todo comments.
    {
      "folke/todo-comments.nvim",
      config = function()
        require("todo-comments").setup({})
      end,
    },
    -- Beautiful notification.
    {
      "rcarriga/nvim-notify",
      config = function()
        -- Setup notify
        local notify = require("notify")
        notify.setup({ max_width = 70 })
        vim.notify = notify
      end,
    },
    -- Nice LSP progress UI.
    {
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup({})
      end,
    },
    -- Better motion.
    {
      "ggandor/lightspeed.nvim",
      config = function()
        require("lightspeed").setup({})
      end,
    },
    -- Auto adjusts `shiftwidth` and `expandtab`
    { "tpope/vim-sleuth" },
    -- Surround.
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
  }

  -- Rust
  minv.builtin.treesitter.install["rust"] = true
  minv.builtin.lsp.server_settings.rust_analyzer = {
    ["rust-analyzer"] = {
      experimental = {
        procAttrMacros = true,
      },
    },
  }

  -- Lua
  minv.builtin.lsp.formatters.stylua = {}
end

return M
