local M = {}

---@param minv MiNV
function M.setup(minv)
  local utils = require("minv.utils")

  local function pre_hook(ctx)
    local comment_utils = require("Comment.utils")
    local cmstring_utils = require("ts_context_commentstring.utils")

    local key = "__default"
    if ctx.ctype ~= comment_utils.ctype.line then
      key = "__multiline"
    end

    local location = nil
    if ctx.ctype == comment_utils.ctype.block then
      location = cmstring_utils.get_cursor_location()
    elseif
      ctx.cmotion == comment_utils.cmotion.v
      or ctx.cmotion == comment_utils.cmotion.V
    then
      location = cmstring_utils.get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring({
      key = key,
      location = location,
    })
  end

  local keys = {
    toggle = {
      line = { utils.register_key(), "Toggle line comments" },
      block = { utils.register_key(), "Toggle block comments" },
    },
    oplead = {
      line = { utils.register_key(), "Toggle line comments" },
      block = { utils.register_key(), "Toggle block comments" },
    },
    insert = {
      above = { utils.register_key(), "Insert comment above" },
      below = { utils.register_key(), "Insert comment below" },
      eol = { utils.register_key(), "Insert comment at EOL" },
    },
  }

  ---@param group string
  local function make_mapping(group)
    local mapping = {}
    for k, v in pairs(keys[group]) do
      mapping[k] = v[1]
    end
    return mapping
  end

  ---@vararg string[]
  local function make_source(...)
    local source = {}
    for _, group in ipairs({ ... }) do
      for k, v in pairs(keys[group]) do
        source[string.format("comment.%s_%s", group, k)] = {
          v[1],
          v[2],
          noremap = false,
        }
      end
    end
    return source
  end

  -- Setup comments.
  require("Comment").setup(
    vim.tbl_extend("force", minv.plugins.treesitter.comment, {
      pre_hook = pre_hook,
      toggler = make_mapping("toggle"),
      opleader = make_mapping("oplead"),
      extra = make_mapping("insert"),
      mappings = {
        basic = true,
        extra = true,
        extended = false,
      },
    })
  )

  -- Set keybindings.
  minv.keybindings.n:apply(false, make_source("toggle", "oplead", "insert"))
  minv.keybindings.x:apply(false, make_source("oplead"), { mode = "x" })
end

return M
