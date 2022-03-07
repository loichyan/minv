local M = {}

---@param minv MiNV
function M.setup(minv)
  local utils = require("utils")

  -- Setup toggleterm.
  local k_toggle = utils.register_key()
  require("toggleterm").setup({
    direction = "float",
    float_opts = {
      border = minv.settings.border,
    },
    open_mapping = k_toggle,
  })

  -- Set keybindings.
  minv.keybindings.n:apply(false, {
    ["terminal.toggle"] = { k_toggle, "Toggle terminal", noremap = false },
  })
  utils.autocmd("TermOpen", "term://*toggleterm#*", function()
    minv.keybindings.terminal:apply(true, {
      ["terminal.toggle"] = { k_toggle, "Toggle terminal", noremap = false },
    }, { mode = "t", buffer = 0 })
  end)
end

return M
