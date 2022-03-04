local M = {}

function M.preset()
  ---@class MiNVKeymaps
  local preset = {
    ---Save to file.
    save = "<C-s>",
    ---Escape insert mode.
    esc_insert = { "jk", "kj" },
  }
  return preset
end

---@param keymaps MiNVKeymaps
function M.setup(keymaps)
  local utils = require("utils")
  utils.keymaps({
    { keymaps.save, "<Cmd>write<CR>" },
    { "<Esc>", "<Cmd>nohlsearch<CR>" },
  })
  utils.keymaps({
    mode = "i",
    { keymaps.esc_insert, "<esc>" },
  })
  -- nohlsearch.
end

return M
