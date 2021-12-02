local M = {}

function M.preset()
  ---@class MiNVKeymaps
  local preset = {
    --- Save to file.
    save = "<C-s>",
    --- Escape insert mode.
    esc_insert = { "jk", "kj" },
  }
  return preset
end

---@param keymaps MiNVKeymaps
function M.setup(keymaps)
  local utils = require("utils")
  utils.map("n", keymaps.save, ":write<CR>")
  utils.map("i", keymaps.esc_insert, "<Esc>")
end

return M
