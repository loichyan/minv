local M = {}

function M.preset()
  ---@class MiNVPresetCmp
  local preset = {
    formatting = {
      fields = { "kind", "abbr", "menu" },
      kind = {
        Class = "",
        Color = "",
        Constant = "ﲀ",
        Constructor = "",
        Enum = "練",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "",
        Folder = "",
        Function = "",
        Interface = "ﰮ",
        Keyword = "",
        Method = "",
        Module = "",
        Operator = "",
        Property = "",
        Reference = "",
        Snippet = "",
        Struct = "",
        Text = "",
        TypeParameter = "",
        Unit = "塞",
        Value = "",
        Variable = "",
      },
      menu = {
        luasnip = "[Snippet]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        buffer = "[BUF]",
        path = "[Path]",
      },
      dup = {
        luasnip = 1,
        nvim_lsp = 0,
        nvim_lua = 0,
        buffer = 1,
        path = 1,
      },
      dup_default = 0,
    },
    sources = {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "buffer" },
      { name = "path" },
    },
  }
  return preset
end

---@param preset MiNVPresetCmp
function M.setup(cmp, luasnip, preset)
  cmp.setup({
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
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end),
    },
    sources = preset.sources,
  })
end

return M
