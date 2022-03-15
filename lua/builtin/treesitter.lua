local M = {}

function M.preset()
  return {
    ---Treesitters to be installed.
    ensure_installed = {
      "lua",
    },
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
    },
  }
end

---@param minv MiNV
function M.setup(minv)
  local utils = require("utils")

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
    elseif ctx.cmotion == comment_utils.cmotion.v or ctx.cmotion == comment_utils.cmotion.V then
      location = cmstring_utils.get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring({
      key = key,
      location = location,
    })
  end

  local keys = {
    n = {
      toggle_line = { utils.register_key(), "Toggle line comments" },
      toggle_block = { utils.register_key(), "Toggle block comments" },
      insert_above = { utils.register_key(), "Insert comment above" },
      insert_below = { utils.register_key(), "Insert comment below" },
      insert_eol = { utils.register_key(), "Insert comment at EOL" },
    },
    x = {
      operator_line = { utils.register_key(), "Toggle line comments" },
      operator_block = { utils.register_key(), "Toggle block comments" },
    },
  }

  local function load_source(opts)
    local source = {}
    for k, v in pairs(opts) do
      source["comment." .. k] = { v[1], v[2], noremap = false }
    end
    return source
  end

  -- Setup treesitter.
  require("nvim-treesitter.configs").setup(minv.builtin.treesitter)

  -- Setup comments.
  require("Comment").setup(vim.tbl_extend("force", minv.builtin.comment, {
    pre_hook = pre_hook,
    toggler = {
      line = keys.n.toggle_line[1],
      block = keys.n.toggle_block[1],
    },
    opleader = {
      line = keys.x.operator_line[1],
      block = keys.x.operator_block[1],
    },
    extra = {
      above = keys.n.insert_above[1],
      below = keys.n.insert_below[1],
      eol = keys.n.insert_eol[1],
    },
    mappings = {
      basic = true,
      extra = true,
      extended = false,
    },
  }))

  -- Set keybindings.
  minv.keybindings.n:apply(false, load_source(keys.n))
  minv.keybindings.x:apply(false, load_source(keys.x), { mode = "x" })
end

return M
