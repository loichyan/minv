local M = {}

local function _make_mapping()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  local function check_backspace()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
  end

  local function locally_jumpable(dir)
    return luasnip.jumpable(dir) and luasnip.in_snippet()
  end

  return {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
    }),
    ["<C-e>"] = cmp.mapping.close(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif locally_jumpable(1) then
        luasnip.jump(1)
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif locally_jumpable(-1) then
        luasnip.jump(-1)
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end),
  }
end

function M.preset()
  local utils = require("utils")

  ---@class MiNVPresetCmp
  local preset = {
    after = utils.callback.new(),
    setup = utils.lazy.new(function()
      local cmp = require("cmp")

      ---@class MiNVBuiltinCmpSetup
      local setup = {
        cmp = {
          documentation = {
            border = "rounded",
          },
          confirmation = {
            default_behavior = cmp.ConfirmBehavior.Replace,
          },
          mapping = _make_mapping(),
        },
        luasnip = {
          histroy = false,
        },
      }
      return setup
    end),
    formatting = {
      kind = {
        Class = " ",
        Color = " ",
        Constant = "ﲀ ",
        Constructor = " ",
        Enum = "練 ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = "ﰮ ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Operator = " ",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = "塞 ",
        Value = " ",
        Variable = " ",
      },
      menu = {
        luasnip = "[SNIP]",
        nvim_lsp = "[LSP]",
        path = "[PATH]",
        buffer = "[BUF]",
      },
      dup = {
        luasnip = 1,
        nvim_lsp = 1,
        path = 1,
        buffer = 0,
      },
      dup_default = 1,
    },
    sources = utils.set.new({
      "luasnip",
      "nvim_lsp",
      "path",
      "buffer",
    }),
  }
  return preset
end

---@param preset MiNVPresetCmp
function M.setup(preset)
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local utils = require("utils")

  ---Make sources.
  local function make_sources()
    local sources = {}
    for _, name in ipairs(preset.sources:to_list()) do
      table.insert(sources, { name = name })
    end
    return cmp.config.sources(sources)
  end

  -- Setup plugins.
  local setup = preset.setup:apply()
  luasnip.config.setup(setup.luasnip)
  cmp.setup(utils.tbl_merge(setup.cmp, {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = preset.formatting.kind[vim_item.kind]
        vim_item.menu = preset.formatting.menu[entry.source.name]
        vim_item.dup = preset.formatting.dup[entry.source.name] or preset.formatting.dup_default
        return vim_item
      end,
    },
    sources = make_sources(),
  }))

  -- Load friendly snippets.
  require("luasnip.loaders.from_vscode").lazy_load()
end

return M
