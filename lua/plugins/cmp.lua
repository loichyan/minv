local M = {}

function M.preset()
  ---@class MiNVPresetCmp
  local preset = {
    keymaps = {
      scroll_down = "<C-f>",
      scroll_up = "<C-d>",
      complete = "<C-Space>",
      confirm = "<CR>",
      close = "<C-e>",
      select_next = "<Tab>",
      select_prev = "<S-Tab>",
    },
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

local function make_mapping(cmp, luasnip, keymaps)
  -- Functions to handle keymap.
  local map_fn = {
    scroll_up = cmp.mapping.scroll_docs(-4),
    scroll_down = cmp.mapping.scroll_docs(4),
    complete = cmp.mapping.complete(),
    confirm = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.confirm({ select = false }) then
        if luasnip.jumpable() then
          luasnip.jump(1)
        end
        return
      elseif luasnip.jumpable() and luasnip.jump(1) then
        return
      else
        fallback()
      end
    end),
    close = cmp.mapping.abort(),
    select_next = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end),
    select_prev = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end),
  }
  -- Collect mappings.
  local mappings = {}
  for k, f in pairs(map_fn) do
    local map_key = keymaps[k]
    if type(map_key) == "table" then
      for _, key in pairs(map_key) do
        mappings[key] = f
      end
    else
      mappings[map_key] = f
    end
  end
  return mappings
end

---@param preset MiNVPresetCmp
function M.setup(preset, luasnip, autopairs, cmp_autopiars, cmp)
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
    mapping = make_mapping(cmp, luasnip, preset.keymaps),
    sources = preset.sources,
  })
  autopairs.setup({
    check_ts = true,
  })
  cmp.event:on("confirm_done", cmp_autopiars.on_confirm_done())
end

return M
