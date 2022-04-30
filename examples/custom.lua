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
  vim.list_extend(minv.builtin.cmp.sources, { { name = "nvim_lsp_signature_help" } })

  -- Configure autocmds.
  vim.list_extend(minv.autocmds.q_to_close, { "notify" })

  -- Add buttons to dashboard.
  table.insert(
    minv.builtin.dashboard.buttons,
    3,
    { "p", "  Recent Projects", "<Cmd>Telescope projects<CR>" }
  )

  -- Add extra treesitters.
  vim.list_extend(minv.builtin.treesitter.ensure_installed, { "rust" })

  -- Lsp servers
  vim.list_extend(minv.builtin.lsp.installer.ensure_installed, { "rust_analyzer" })

  -- Rust-analyzer
  minv.builtin.lsp.configs.rust_analyzer = {
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
    minv.builtin.lsp.configs.sumneko_lua = lua_dev
  end

  -- Use stylua as Lua formatter.
  minv.builtin.lsp.formatters.stylua = {}

  -- Return extra plugins.
  return {
    -- Extra treesitter modules.
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
    -- Todo comments
    {
      "folke/todo-comments.nvim",
      config = function()
        require("todo-comments").setup({})
      end,
    },
    -- Nvim lua libs.
    { "folke/lua-dev.nvim" },
    -- Beautiful notifications.
    {
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require("notify")
        vim.notify.setup({ max_width = 70 })
        -- Load telescope extensions.
        require("telescope").load_extension("notify")
      end,
    },
    -- Project
    {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup({
          ignore_lsp = { "null-ls" },
        })
      end,
    },
    -- Surround
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
    -- Auto adjusts `shiftwidth` and `expandtab`
    { "tpope/vim-sleuth" },
    -- Signature help
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    -- Autopairs
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
  }
end

require("minv").setup(custom)
