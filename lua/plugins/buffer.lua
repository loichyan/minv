local M = {}

function M.preset()
  ---@class MiNVPresetBuffer
  local preset = {
    keymaps = {
      previous = "<S-h>",
      next = "<S-l>",
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
end

return M
