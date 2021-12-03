local M = {}

function M.preset()
  ---@class MiNVPresetBuffer
  local preset = {
    keymaps = {
      previous = "<S-h>",
      next = "<S-l>",
      close = "<Leader>x",
    },
  }
  return preset
end

---@param preset MiNVPresetBuffer
function M.setup(preset)
  local utils = require("utils")
  local keymaps = preset.keymaps
  utils.map("n", keymaps.next, ":BufferNext<CR>")
  utils.map("n", keymaps.previous, ":BufferPrevious<CR>")
  utils.map("n", keymaps.close, ":BufferClose<CR>")
end

return M
