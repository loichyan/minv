---@param minv MiNV
---@return any[]
local function custom(minv)
  -- Add keybindings.
  minv.keybindings.n:extend({
    ["<Leader>f"] = {
      ["n"] = { "<Cmd>Telescope notify<CR>", "Search notifications" },
      ["t"] = { "<Cmd>TodoTelescope<CR>", "Search TODOs" },
    },
  })

  -- Add cmp sources.
  vim.list_extend(minv.plugins.cmp.config.sources, { { name = "nvim_lsp_signature_help" } })

  -- Configure autocmds.
  vim.list_extend(minv.autocmds.q_to_close, { "notify" })

  -- Add buttons to dashboard.
  table.insert(
    minv.plugins.ui.dashboard.buttons,
    3,
    { "p", "  Recent Projects", "<Cmd>Telescope projects<CR>" }
  )

  -- Add extra treesitters.
  vim.list_extend(minv.plugins.treesitter.config.ensure_installed, { "rust" })

  -- Lsp servers
  vim.list_extend(minv.plugins.lsp.installer.ensure_installed, { "rust_analyzer" })

  local lsp = minv.plugins.lsp.config
  -- Rust-analyzer
  lsp.configs.rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        experimental = {
          procAttrMacros = true,
        },
      },
    },
  }

  -- Extend sumneko_lua with vim library.
  local ok_lua_dev, lua_dev = pcall(require, "lua-dev")
  if ok_lua_dev then
    lua_dev = lua_dev.setup({
      lspconfig = {
        on_attach = function(client, _)
          local cap = client.resolved_capabilities
          -- Disable formatting feature.
          cap.document_formatting = false
        end,
      },
    })
    -- Add MiNV to runtime paths.
    lua_dev.settings["Lua"].workspace.library[vim.fn.expand("~/.config/nvim/lua")] = true
    lsp.configs.sumneko_lua = lua_dev
  end

  -- Use stylua as Lua formatter.
  lsp.formatters.stylua = {}

  minv.plugins.treesitter.plug:extend({
    {
      "andymass/vim-matchup",
      config = function()
        require("nvim-treesitter").define_modules({
          matchup = {
            enable = true,
          },
        })
      end,
    },
    {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup({ check_ts = true })
        require("cmp").event:on(
          "confirm_done",
          require("nvim-autopairs.completion.cmp").on_confirm_done()
        )
      end,
    },
  })
  minv.plugins.lsp.plug:extend({
    { "folke/lua-dev.nvim" },
  })
  minv.plugins.cmp.plug:extend({
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
  })
  minv.plugins.ui.plug:extend({
    {
      "folke/todo-comments.nvim",
      config = function()
        require("todo-comments").setup({})
      end,
    },
    {
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require("notify")
        vim.notify.setup({ max_width = 70 })
        require("telescope").load_extension("notify")
      end,
    },
  })
  minv.plugins.extra:extend({
    -- Surround
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
    -- Auto adjusts `shiftwidth` and `expandtab`
    { "tpope/vim-sleuth" },
    -- Project
    {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup({
          ignore_lsp = { "null-ls" },
        })
      end,
    },
  })
end

require("minv").setup(custom)
