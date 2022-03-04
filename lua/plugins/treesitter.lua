local M = {}

function M.preset()
  ---@class MiNVPresetTreesitter
  local preset = {
    setup = {
      treesitter = {},
      comments = {},
    },
    keymaps = {
      toggle_line = "<Leader>/",
      toggle_block = "<Leader>a/",
    },
    after = nil,
    install = {
      ["bash"] = true,
      ["c"] = true,
      ["json"] = true,
      ["lua"] = true,
      ["python"] = true,
    },
    modules = {
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      matchup = {
        enable = true,
      },
      rainbow = {
        enable = true,
        extended_mode = true,
        ---Fluent colors.
        colors = {
          "#E74856",
          "#0078D7",
          "#0099BC",
          "#6B69D6",
          "#00CC6A",
          "#F7630C",
          "#FFB900",
        },
      },
      context_commentstring = {
        config = {},
      },
    },
  }
  return preset
end

---@param preset MiNVPresetTreesitter
function M.setup(preset)
  local treesitter = require("nvim-treesitter.configs")
  local comment = require("Comment")
  local comments_utils = require("Comment.utils")
  local cmstring_utils = require("ts_context_commentstring.utils")
  local cmstring_internal = require("ts_context_commentstring.internal")
  local utils = require("utils")

  -- Ensure `context_commentstring` is enabled.
  preset.modules.context_commentstring.enable = true
  preset.modules.context_commentstring.enable_autocmd = false

  -- Setup treesitter.
  treesitter.setup(utils.tbl_merge(preset.setup.treesitter, preset.modules, {
    ensure_installed = utils.set_to_list(preset.install),
  }))

  -- Setup comments.
  local k_tg_line = utils.register_key()
  local k_tg_block = utils.register_key()
  local k_op_line = utils.register_key()
  local k_op_block = utils.register_key()
  comment.setup(utils.tbl_merge(preset.setup, {
    pre_hook = function(ctx)
      local key = "__default"
      if ctx.ctype ~= comments_utils.ctype.line then
        key = "__multiline"
      end

      local location = nil
      if ctx.ctype == comments_utils.ctype.block then
        location = cmstring_utils.get_cursor_location()
      elseif ctx.cmotion == comments_utils.cmotion.v or ctx.cmotion == comments_utils.cmotion.V then
        location = cmstring_utils.get_visual_start_location()
      end

      return cmstring_internal.calculate_commentstring({
        key = key,
        location = location,
      })
    end,
    toggler = {
      line = k_tg_line,
      block = k_tg_block,
    },
    opleader = {
      line = k_op_line,
      block = k_op_block,
    },
    mappings = {
      basic = true,
      extra = false,
      extended = false,
    },
  }))

  -- Set keymaps.
  local keymaps = preset.keymaps
  utils.keymaps({
    noremap = false,
    { keymaps.toggle_line, k_tg_line },
    { keymaps.toggle_block, k_tg_block },
  })
  utils.keymaps({
    mode = "x",
    noremap = false,
    { keymaps.toggle_line, k_op_line },
    { keymaps.toggle_block, k_op_block },
  })
end

return M
