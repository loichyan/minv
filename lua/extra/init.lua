local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVExtra
  local preset = {
    cmp_sources = require("extra.cmp_sources").preset(),
    ts_modules = require("extra.ts_modules").preset(),
    ts_context = {
      enable = true,
      setup = {},
      after = utils.callback.new(),
    },
    trouble = require("extra.trouble").preset(),
    todo_comments = {
      enable = true,
      setup = {},
      after = utils.callback.new(),
    },
    notify = {
      enable = true,
      setup = {
        max_width = 70,
      },
      after = utils.callback.new(),
    },
    fidget = {
      enable = true,
      setup = {},
      after = utils.callback.new(),
    },
    indent_blankline = {
      enable = true,
      setup = {
        show_current_context = true,
        use_treesitter = true,
      },
      after = utils.callback.new(),
    },
    diffview = require("extra.diffview").preset(),
    lightspeed = {
      enable = true,
      setup = {},
      after = utils.callback.new(),
    },
    autopairs = {
      enable = true,
      setup = {
        check_ts = true,
      },
      after = utils.callback.new(),
    },
    surround = {
      enable = true,
      after = utils.callback.new(),
    },
    repeat_ = {
      enable = true,
      after = utils.callback.new(),
    },
    sleuth = {
      enable = true,
      after = utils.callback.new(),
    },
  }

  return preset
end

---@param minv MiNV
---@param customize fun(extra:MiNVExtra)
function M.setup(minv, customize)
  -- Load customization.
  local extra = M.preset()
  customize(extra)

  -- Add extra plugins.
  _MINV_EXTRA = extra
  local ts_modules = extra.ts_modules
  local cmp_sources = extra.cmp_sources
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
      disable = not extra.ts_context.enable,
      config = function()
        require("treesitter-context").setup(_MINV_EXTRA.ts_context.setup)
        _MINV_EXTRA.ts_context.after:apply()
      end,
    },
    ---------------------
    -- Nice UI Plugins --
    ---------------------
    -- Trouble.
    {
      "folke/trouble.nvim",
      disable = not extra.trouble.enable,
      config = function()
        require("extra.trouble").setup(_MINV_EXTRA.trouble)
        _MINV_EXTRA.trouble.after:apply()
      end,
    },
    -- Todo comments.
    {
      "folke/todo-comments.nvim",
      disable = not extra.todo_comments.enable,
      config = function()
        require("todo-comments").setup(_MINV_EXTRA.todo_comments.setup)
        _MINV_EXTRA.todo_comments.after:apply()
      end,
    },
    -- Beautiful notification.
    {
      "rcarriga/nvim-notify",
      disable = not extra.notify.enable,
      config = function()
        vim.notify = require("notify")
        vim.notify.setup(_MINV_EXTRA.notify.setup)
        _MINV_EXTRA.notify.after:apply()
      end,
    },
    -- Nice LSP progress UI.
    {
      "j-hui/fidget.nvim",
      disable = not extra.fidget.enable,
      config = function()
        require("fidget").setup(_MINV_EXTRA.fidget.setup)
        _MINV_EXTRA.fidget.after:apply()
      end,
    },
    -- Indent blankline.
    {
      "lukas-reineke/indent-blankline.nvim",
      disable = not extra.indent_blankline.enable,
      config = function()
        require("indent_blankline").setup(_MINV_EXTRA.indent_blankline.setup)
        _MINV_EXTRA.indent_blankline.after:apply()
      end,
    },
    ---------------------------
    -- Beautiful diff viewer --
    ---------------------------
    {
      "sindrets/diffview.nvim",
      disable = not extra.diffview.enable,
      config = function()
        require("extra.diffview").setup(_MINV_EXTRA.diffview)
        _MINV_EXTRA.diffview.after:apply()
      end,
    },
    ----------------------
    -- Speed up motions --
    ----------------------
    {
      "ggandor/lightspeed.nvim",
      disable = not extra.lightspeed,
      config = function()
        require("lightspeed").setup(_MINV_EXTRA.lightspeed.setup)
        _MINV_EXTRA.lightspeed.after:apply()
      end,
    },
    ------------
    -- Others --
    ------------
    -- Autopairs.
    {
      "windwp/nvim-autopairs",
      disable = not extra.autopairs.enable,
      config = function()
        -- Setup autopairs.
        require("nvim-autopairs").setup(_MINV_EXTRA.autopairs.setup)
        require("cmp").event:on(
          "confirm_done",
          require("nvim-autopairs.completion.cmp").on_confirm_done()
        )
        _MINV_EXTRA.autopairs.after:apply()
      end,
    },
    -- Surround.
    {
      "tpope/vim-surround",
      disable = not extra.surround.enable,
      config = function()
        _MINV_EXTRA.surround.after:apply()
      end,
    },
    {
      "tpope/vim-repeat",
      disalbe = not extra.repeat_.enable,
      config = function()
        _MINV_EXTRA.repeat_.after:apply()
      end,
    },
    -- Auto adjusts `shiftwidth` and `expandtab`
    {
      "tpope/vim-sleuth",
      disable = not extra.sleuth.enable,
      config = function()
        _MINV_EXTRA.sleuth.after:apply()
      end,
    },
  })

  -- Apply customization.
  require("extra.cmp_sources").apply(extra.cmp_sources, minv)
  require("extra.trouble").apply(extra.trouble, minv)
  require("extra.ts_modules").apply(extra.ts_modules, minv)
end

return M
