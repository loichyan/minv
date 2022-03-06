local M = {}

function M.preset()
  local utils = require("utils")

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
    after = utils.callback.new(),
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
    { keymaps.toggle, k_toggle },
  }, {
    noremap = false,
  })
  utils.autocmd("TermOpen", "term://*toggleterm#*", function()
    local buf = vim.api.nvim_get_current_buf()
    utils.keymaps({
      { keymaps.toggle, k_toggle },
    }, {
      mode = "t",
      buffer = buf,
      noremap = false,
    })
  end)
end

return M
