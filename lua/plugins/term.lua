local M = {}

function M.preset()
  ---@class MiNVPresetTree
  local preset = {
    keymaps = {
      --- Toggle terminal.
      toggle = "<C-t>",
      --- Escape terminal mode.
      esc_terminal = "<Esc>",
    },
  }
  return preset
end

---@param preset MiNVPresetTree
function M.setup(preset)
  local term = require("toggleterm")
  local utils = require("utils")

  local k_toggle = utils.register_key()
  term.setup({ open_mapping = k_toggle })
  local keymaps = preset.keymaps
  utils.keymaps({
    noremap = false,
    { keymaps.toggle, k_toggle },
  })
  -- Register a funtions to set keymaps.
  local set_map = utils.register_fn(function()
    local buf = vim.api.nvim_get_current_buf()
    utils.keymaps({
      mode = "t",
      buffer = buf,
      noremap = false,
      { keymaps.toggle, k_toggle },
    })
    utils.keymaps({
      mode = "t",
      buffer = buf,
      { keymaps.esc_terminal, "<C-\\><C-n>" },
    })
  end)
  local cmd = string.format([[lua require("utils").call_fn(%d)]], set_map)
  utils.autocmd("TermOpen", "term://*toggleterm#*", cmd)
end

return M
