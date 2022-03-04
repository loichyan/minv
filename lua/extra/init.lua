local M = {}

---Nice UI plugins, including `todo-comments`, `notify` and `fidget`.
---@param minv MiNV
function M.ui(minv)
  vim.list_extend(minv.extra, {
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
  })
end

---Plugins for better coding experience, including `surround`, `repeat` and `sleuth`.
---@param minv MiNV
function M.easily_coding(minv)
  vim.list_extend(minv.extra, {
    -- Surround.
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
    -- Auto adjusts `shiftwidth` and `expandtab`
    { "tpope/vim-sleuth" },
  })
end

---Useful treesitter modules, including `context` and `textobjects`.
---@param minv MiNV
function M.ts_modules(minv)
  vim.list_extend(minv.extra, {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    {
      "romgrk/nvim-treesitter-context",
      config = function()
        require("treesitter-context").setup({})
      end,
    },
  })
  minv.builtin.treesitter.modules.textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  }
end

---Pretty git diff viewer.
---@param minv MiNV
function M.diffview(minv)
  vim.list_extend(minv.extra, {
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
  })
end

---A plugin to speed up motions.
---@param minv MiNV
function M.lightspeed(minv)
  vim.list_extend(minv.extra, {
    {
      "ggandor/lightspeed.nvim",
      config = function()
        require("lightspeed").setup({})
      end,
    },
  })
end

---Load all extra plugins.
---@param minv MiNV
function M.setup(minv)
  M.ui(minv)
  M.easily_coding(minv)
  M.ts_modules(minv)
  M.diffview(minv)
  M.lightspeed(minv)
end

return M
