local M = {}

function M.preset()
  local kind = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
  }
  local menu = {
    luasnip = "[SNIP]",
    nvim_lsp = "[LSP]",
    path = "[PATH]",
    buffer = "[BUF]",
  }
  local dup = {
    ["buffer"] = true,
  }

  local preset = {
    ---Sources to be loaded.
    sources = {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "buffer" },
    },
    formatting = {
      ---Single letter indicating the type of completion.
      kind = kind,
      ---Text displayed after `word`.
      menu = menu,
      ---Indicates entries should not be added when same words present.
      dup = dup,
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = kind[vim_item.kind]
        vim_item.menu = menu[entry.source.name]
        vim_item.dup = 1
        if dup[entry.source.name] == true then
          vim_item.dup = 0
        end
        return vim_item
      end,
    },
  }

  local ok, cmp = pcall(require, "cmp")
  if ok then
    preset = vim.tbl_extend("force", preset, {
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      confirmation = {
        default_behavior = cmp.ConfirmBehavior.Replace,
      },
    })
  end

  return preset
end

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

  local mapping, unmapped = minv.keybindings.cmp:map({
    ["cmp.scroll_down"] = cmp.mapping.scroll_docs(4),
    ["cmp.scroll_up"] = cmp.mapping.scroll_docs(-4),
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
  for key, val in pairs(unmapped) do
    local fn, _ = unpack(val)
    mapping[key] = fn
  end

  -- Setup luasnip.
  luasnip.config.setup(minv.builtin.luasnip)

  -- Setup cmp.
  local preset = minv.builtin.cmp
  cmp.setup(vim.tbl_extend("force", preset, {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    formatting = {
      fields = preset.formatting.fields,
      format = preset.formatting.format,
    },
    mapping = mapping,
  }))

  -- Load friendly-snippets.
  require("luasnip.loaders.from_vscode").lazy_load()
end

return M
