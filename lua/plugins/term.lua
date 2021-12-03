local M = {}

function M.preset()
  ---@class MiNVPresetTree
  local preset = {
    keymaps = {
      toggle = "<C-t>",
    },
  }
  return preset
end

---@param preset MiNVPresetTree
function M.setup(preset, term)
  term.setup({ open_mapping = "<Plug>(_MiNVTermToggle)" })
  local utils = require("utils")
  local keymaps = preset.keymaps
  local opts = { noremap = false }
  utils.map("n", keymaps.toggle, "<Plug>(_MiNVTermToggle)", opts)
  -- Register a funtions to set keymaps.
  local f_id = utils._register_fn(function()
    utils.map("t", keymaps.toggle, "<Plug>(_MiNVTermToggle)", opts)
  end)
  local cmd = string.format([[lua require("utils")._call_fn(%d)]], f_id)
  utils.autocmd("TermEnter", "term://*toggleterm#*", cmd)
end

return M
