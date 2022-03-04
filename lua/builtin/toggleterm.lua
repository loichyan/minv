local M = {}

function M.preset()
  ---@class MiNVPresetTree
  local preset = {
    setup = {
      direction = "float",
      float_opts = {
        border = "rounded",
      },
    },
    keymaps = {
      ---Toggle terminal.
      toggle = "<C-t>",
    },
    after = nil,
  }
  return preset
end

---@param preset MiNVPresetTree
function M.setup(preset)
  local toggleterm = require("toggleterm")
  local utils = require("utils")

  -- Setup toggleterm.
  local k_toggle = utils.register_key()
  toggleterm.setup(utils.tbl_merge(preset.setup, { open_mapping = k_toggle }))

  -- Set keymaps.
  local keymaps = preset.keymaps
  utils.keymaps({
    noremap = false,
    { keymaps.toggle, k_toggle },
  })
  utils.autocmd("TermOpen", "term://*toggleterm#*", function()
    local buf = vim.api.nvim_get_current_buf()
    utils.keymaps({
      mode = "t",
      buffer = buf,
      noremap = false,
      { keymaps.toggle, k_toggle },
    })
  end)
end

return M
