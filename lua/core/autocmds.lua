local M = {}

---@param autocmds MiNVAutocmds
function M.setup(autocmds)
  local utils = require("utils")
  ---@param enable boolean
  ---@param event string
  ---@param pat string
  ---@param cmd string
  local function au(enable, event, pat, cmd)
    if enable then
      utils.autocmd(event, pat, cmd)
    end
  end
  au(
    autocmds.hl_yank,
    "TextYankPost",
    "*",
    [[lua require("vim.highlight").on_yank({higroup = "Search", timeout = 200})]]
  )
  au(autocmds.trim_spaces, "BufWritePre", "*", [[:%s/\s\+$//e]])
end

return M
