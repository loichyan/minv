local M = {}

function M.preset()
  ---@class MiNVPresetTree
  local preset = {
    keymaps = {
      --- Toggle terminal.
      toggle = "<C-t>",
      --- Escape terminal mode.
      esc_terminal = {"<S-j><S-k>", "<S-k><S-j>"},
    },
  }
  return preset
end

---@param preset MiNVPresetTree
function M.setup(preset, term)
  local utils = require("utils")
  local k_toggle = utils._register_key()
  term.setup({ open_mapping = k_toggle })
  local keymaps = preset.keymaps
  local opts = { noremap = false }
  utils.map("n", keymaps.toggle, k_toggle, opts)
  -- Register a funtions to set keymaps.
  local set_map = utils._register_fn(function()
    local map = utils.make_buf_map(0)
    map("t", keymaps.toggle, k_toggle, opts)
    map("t", keymaps.esc_terminal, [[<C-\><C-n>]])
  end)
  local cmd = string.format([[lua require("utils")._call_fn(%d)]], set_map)
  utils.autocmd("TermOpen", "term://*toggleterm#*", cmd)
end

return M
