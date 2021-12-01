---@class MiNVAutocmds
local M = {
  -- Hightlight yanked text.
  hl_yank = {
    "TextYankPost",
    "*",
    [[lua require("vim.highlight").on_yank({higroup = "Search", timeout = 200})]],
  },
  -- Remove trailing spaces.
  trim_spaces = { "BufWritePre", "*", [[:%s/\s\+$//e]] },
}

return M
