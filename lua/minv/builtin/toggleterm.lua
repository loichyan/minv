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
  local preset = minv.plugins.ui.toggleterm
  local k_toggle = require("minv.utils").register_key()
  local sources = {
    ["terminal.toggle"] = { k_toggle, "Toggle terminal", noremap = false },
  }
  require("toggleterm").setup(vim.tbl_extend("force", preset, {
    insert_mappings = true,
    terminal_mappings = true,
    open_mapping = k_toggle,
    on_open = function(term)
      minv.keybindings.terminal:apply(
        sources,
        { mode = "t", buffer = term.bufnr }
      )
      if preset.on_open ~= nil then
        preset.on_open(term)
      end
    end,
  }))

  -- Set keybindings.
  minv.keybindings.terminal:apply(sources)
end

return M
