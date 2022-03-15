local M = {}

function M.preset()
  return {
    direction = "float",
    float_opts = {
      border = "rounded",
    },
  }
end

---@param minv MiNV
function M.setup(minv)
  -- Setup toggleterm.
  local preset = minv.builtin.toggleterm
  local k_toggle = require("utils").register_key()
  require("toggleterm").setup(vim.tbl_extend("force", preset, {
    insert_mappings = true,
    terminal_mappings = true,
    open_mapping = k_toggle,
    on_open = function(term)
      minv.keybindings.terminal:apply(true, {
        ["terminal.toggle"] = { k_toggle, "Toggle terminal", noremap = false },
      }, { mode = "t", buffer = term.bufnr })
      pcall(preset.on_open, term)
    end,
  }))

  -- Set keybindings.
  minv.keybindings.n:apply(false, {
    ["terminal.toggle"] = { k_toggle, "Toggle terminal", noremap = false },
  })
end

return M
