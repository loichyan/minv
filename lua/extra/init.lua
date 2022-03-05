local M = {}

---@class MiNVExtra
_MINV_EXTRA = {
  cmp_sources = require("extra.cmp_sources").preset(),
  ts_modules = require("extra.ts_modules").preset(),
  ts_context = {
    enable = true,
    setup = {},
    after = nil,
  },
  trouble = require("extra.trouble").preset(),
  todo_comments = {
    enable = true,
    setup = {},
    after = nil,
  },
  notify = {
    enable = true,
    setup = {
      max_width = 70,
    },
    after = nil,
  },
  fidget = {
    enable = true,
    setup = {},
    after = nil,
  },
  indent_blankline = {
    enable = true,
    setup = {
      show_current_context = true,
      use_treesitter = true,
    },
    after = nil,
  },
  diffview = require("extra.diffview").preset(),
  lightspeed = {
    enable = true,
    setup = {},
    after = nil,
  },
  autopairs = {
    enable = true,
    setup = {
      check_ts = true,
    },
    after = nil,
  },
  surround = {
    enable = true,
    after = nil,
  },
  repeat_ = {
    enable = true,
    after = nil,
  },
  sleuth = {
    enable = true,
    after = nil,
  },
}

---@param minv MiNV
---@param customize fun(extra:MiNVExtra)
function M.setup(minv, customize)
  local preset = _MINV_EXTRA

  -- Load customization.
  customize(preset)

  -- Add extra plugins.
  local ts_modules = preset.ts_modules
  local cmp_sources = preset.cmp_sources
  vim.list_extend(minv.extra, {
    -----------------
    -- Cmp sources --
    -----------------
    {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      disable = cmp_sources.nvim_lsp_signature_help,
    },
    -----------------------------------------
    -- Useful treesitter modules & plugins --
    -----------------------------------------
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      disable = not ts_modules.textobjects.enable,
    },
    {
      "p00f/nvim-ts-rainbow",
      requires = "nvim-treesitter/nvim-treesitter",
      disable = not ts_modules.rainbow.enable,
    },
    {
      "romgrk/nvim-treesitter-context",
      disable = not preset.ts_context.enable,
      config = function()
        require("treesitter-context").setup(_MINV_EXTRA.ts_context.setup)
        pcall(_MINV_EXTRA.ts_context.after)
      end,
    },
    ---------------------
    -- Nice UI Plugins --
    ---------------------
    -- Trouble.
    {
      "folke/trouble.nvim",
      disable = not preset.trouble.enable,
      config = function()
        require("extra.trouble").setup(_MINV_EXTRA.trouble)
        pcall(_MINV_EXTRA.trouble.after)
      end,
    },
    -- Todo comments.
    {
      "folke/todo-comments.nvim",
      disable = not preset.todo_comments.enable,
      config = function()
        require("todo-comments").setup(_MINV_EXTRA.todo_comments.setup)
        pcall(_MINV_EXTRA.todo_comments.after)
      end,
    },
    -- Beautiful notification.
    {
      "rcarriga/nvim-notify",
      disable = not preset.notify.enable,
      config = function()
        vim.notify = require("notify")
        vim.notify.setup(_MINV_EXTRA.notify.setup)
        pcall(_MINV_EXTRA.notify.after)
      end,
    },
    -- Nice LSP progress UI.
    {
      "j-hui/fidget.nvim",
      disable = not preset.fidget.enable,
      config = function()
        require("fidget").setup(_MINV_EXTRA.fidget.setup)
        pcall(_MINV_EXTRA.fidget.after)
      end,
    },
    -- Indent blankline.
    {
      "lukas-reineke/indent-blankline.nvim",
      disable = not preset.indent_blankline.enable,
      config = function()
        require("indent_blankline").setup(_MINV_EXTRA.indent_blankline.setup)
        pcall(_MINV_EXTRA.indent_blankline.after)
      end,
    },
    ---------------------------
    -- Beautiful diff viewer --
    ---------------------------
    {
      "sindrets/diffview.nvim",
      disable = not preset.diffview.enable,
      config = function()
        require("extra.diffview").setup(_MINV_EXTRA.diffview)
        pcall(_MINV_EXTRA.diffview.after)
      end,
    },
    ----------------------
    -- Speed up motions --
    ----------------------
    {
      "ggandor/lightspeed.nvim",
      disable = not preset.lightspeed,
      config = function()
        require("lightspeed").setup(_MINV_EXTRA.lightspeed.setup)
        pcall(_MINV_EXTRA.lightspeed.after)
      end,
    },
    ------------
    -- Others --
    ------------
    -- Autopairs.
    {
      "windwp/nvim-autopairs",
      disable = not preset.autopairs.enable,
      config = function()
        -- Setup autopairs.
        require("nvim-autopairs").setup(_MINV_EXTRA.autopairs.setup)
        require("cmp").event:on(
          "confirm_done",
          require("nvim-autopairs.completion.cmp").on_confirm_done()
        )
        pcall(_MINV_EXTRA.autopairs.after)
      end,
    },
    -- Surround.
    {
      "tpope/vim-surround",
      disable = not preset.surround.enable,
      config = function()
        pcall(_MINV_EXTRA.surround.after)
      end,
    },
    {
      "tpope/vim-repeat",
      disalbe = not preset.repeat_.enable,
      config = function()
        pcall(_MINV_EXTRA.repeat_.after)
      end,
    },
    -- Auto adjusts `shiftwidth` and `expandtab`
    {
      "tpope/vim-sleuth",
      disable = not preset.sleuth.enable,
      config = function()
        pcall(_MINV_EXTRA.sleuth.after)
      end,
    },
  })

  -- Apply customization.
  require("extra.cmp_sources").apply(preset.cmp_sources, minv)
  require("extra.trouble").apply(preset.trouble, minv)
  require("extra.ts_modules").apply(preset.ts_modules, minv)
end

return M
