local M = {}

function M.preset()
  local utils = require("utils")

  local ok, cmp = pcall(require, "cmp")
  local default_behavior = nil
  if ok then
    default_behavior = cmp.ConfirmBehavior.Replace
  end

  ---@class MiNVPresetCmp
  local preset = {
    setup = {
      cmp = {
        documentation = {
          border = "rounded",
        },
        confirmation = {
          default_behavior = default_behavior,
        },
      },
      luasnip = {
        histroy = false,
      },
    },
    keymaps = {
      scroll_down = "<C-d>",
      scroll_up = "<C-u>",
      complete = "<C-Space>",
      confirm = "<CR>",
      close = "<C-e>",
      select_next = "<Tab>",
      select_prev = "<S-Tab>",
    },
    after = nil,
    formatting = {
      fields = { "kind", "abbr", "menu" },
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
      dup_default = 0,
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

  -- Make keymaps.
  local function make_mapping()
    local function check_backspace()
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end
    local function locally_jumpable(dir)
      return luasnip.jumpable(dir) and luasnip.in_snippet()
    end
    -- Functions to handle keymap.
    local map_fn = {
      scroll_up = cmp.mapping.scroll_docs(-4),
      scroll_down = cmp.mapping.scroll_docs(4),
      complete = cmp.mapping.complete(),
      confirm = cmp.mapping.confirm({
        select = true,
      }),
      close = cmp.mapping.close(),
      select_next = cmp.mapping(function(fallback)
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
      select_prev = cmp.mapping(function(fallback)
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
    -- Collect mappings.
    local mappings = {}
    for k, f in pairs(map_fn) do
      local lhs = preset.keymaps[k]
      utils.foreach_lhs(lhs, function(l)
        mappings[l] = f
      end)
    end
    return mappings
  end

  ---Make sources.
  local function make_sources()
    local sources = {}
    for _, name in ipairs(preset.sources:to_list()) do
      table.insert(sources, { name = name })
    end
    return sources
  end

  -- Setup luasnip.
  luasnip.config.setup(preset.setup.luasnip)

  -- Load friendly snippets.
  require("luasnip.loaders.from_vscode").lazy_load()

  -- Setup nvim-cmp.
  cmp.setup(utils.tbl_merge(preset.setup.cmp, {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    formatting = {
      fields = preset.formatting.fields,
      format = function(entry, vim_item)
        vim_item.kind = preset.formatting.kind[vim_item.kind]
        vim_item.menu = preset.formatting.menu[entry.source.name]
        vim_item.dup = preset.formatting.dup[entry.source.name] or preset.formatting.dup_default
        return vim_item
      end,
    },
    mapping = make_mapping(),
    sources = make_sources(),
  }))
end

return M
