local M = {}

function M.preset()
  ---@class MiNVPlugBuffer
  local preset = {
    keymaps = {
      previous = "<S-h>",
      next = "<S-l>",
    },
  }
  return preset
end

---@param buffer MiNVPlugBuffer
function M.setup(buffer)
  local utils = require("utils")
  local keymaps = _MINV.builtin.buffer.keymaps
  utils.map("n", keymaps.next, ":BufferNext<CR>")
  utils.map("n", keymaps.previous, ":BufferPrevious<CR>")
end

return M
