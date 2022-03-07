local M = {}

---@param minv MiNV
function M.setup(minv)
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  local function check_backspace()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
  end

  local function locally_jumpable(dir)
    return luasnip.jumpable(dir) and luasnip.in_snippet()
  end

  local mapping, _ = minv.keybindings.cmp:map({
    ["cmp.scroll_down"] = cmp.mapping.scroll_docs(-4),
    ["cmp.scroll_up"] = cmp.mapping.scroll_docs(4),
    ["cmp.complete"] = cmp.mapping.complete(),
    ["cmp.confirm"] = cmp.mapping.confirm({ select = true }),
    ["cmp.close"] = cmp.mapping.close(),
    ["cmp.select_next"] = cmp.mapping(function(fallback)
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
    ["cmp.select_prev"] = cmp.mapping(function(fallback)
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
  })

  local sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
  }
  for _, src in ipairs(minv.builtin.cmp.sources) do
    table.insert(sources, src)
  end

  -- Setup luasnip.
  luasnip.config.setup({})

  -- Setup cmp.
  cmp.setup({
    documentation = {
      border = minv.settings.border,
    },
    confirmation = {
      default_behavior = cmp.ConfirmBehavior.Replace,
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = minv.builtin.cmp.formatting.kind[vim_item.kind]
        vim_item.menu = minv.builtin.cmp.formatting.menu[entry.source.name]
        vim_item.dup = 1
        if minv.builtin.cmp.formatting.dup[entry.source.name] == true then
          vim_item.dup = 0
        end
        return vim_item
      end,
    },
    mapping = mapping,
    sources = sources,
  })

  -- Load friendly-snippets.
  require("luasnip.loaders.from_vscode").lazy_load()
end

return M
