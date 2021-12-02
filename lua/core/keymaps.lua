local M = {}

---@param keymaps MiNVKeymaps
function M.setup(keymaps)
  local utils = require("utils")
  utils.map("n", keymaps.save, ":write<CR>")
  utils.map("i", keymaps.esc_insert, "<Esc>")
end

return M
