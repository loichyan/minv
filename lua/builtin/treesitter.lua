local M = {}

---@param minv MiNV
function M.setup(minv)
  local utils = require("utils")
  local preset = minv.builtin.treesitter

  -- Setup treesitter.
  require("nvim-treesitter.configs").setup({
    ensure_installed = preset.install,
    highlight = preset.highlight,
    incremental_selection = preset.incremental_selection,
    indent = preset.indent,
    context_commentstring = preset.context_commentstring,
  })

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

  -- Setup comments.
  local keys = {
    toggle_line = utils.register_key(),
    toggle_block = utils.register_key(),
    operator_line = utils.register_key(),
    operator_block = utils.register_key(),
    insert_above = utils.register_key(),
    insert_below = utils.register_key(),
    insert_eol = utils.register_key(),
  }
  require("Comment").setup({
    pre_hook = pre_hook,
    toggler = {
      line = keys.toggle_line,
      block = keys.toggle_block,
    },
    opleader = {
      line = keys.operator_line,
      block = keys.operator_block,
    },
    extra = {
      above = keys.insert_above,
      below = keys.insert_below,
      eol = keys.insert_eol,
    },
    mappings = {
      basic = true,
      extra = true,
      extended = false,
    },
  })

  -- Set keybindings.
  local label_line = "Toggle line comments"
  local lable_block = "Toggle block comments"
  minv.keybindings.n:apply(false, {
    ["comment.toggle_line"] = { keys.toggle_line, label_line, noremap = false },
    ["comment.toggle_block"] = { keys.toggle_block, lable_block, noremap = false },
    ["comment.operator_line"] = { keys.operator_line, label_line, noremap = false },
    ["comment.operator_block"] = { keys.operator_block, lable_block, noremap = false },
    ["comment.insert_above"] = { keys.insert_above, "Insert comment above", noremap = false },
    ["comment.insert_below"] = { keys.insert_below, "Insert comment below", noremap = false },
    ["comment.insert_eol"] = { keys.insert_eol, "Insert comment at EOL", noremap = false },
  })
  minv.keybindings.x:apply(false, {
    ["comment.operator_line"] = { keys.operator_line, label_line, noremap = false },
    ["comment.operator_block"] = { keys.operator_block, lable_block, noremap = false },
  }, { mode = "x" })
end

return M
