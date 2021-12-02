local M = {}

function M.preset()
  ---@class MiNVAutocmds
  local preset = {
    --- Hightlight yanked text.
    hl_yank = true,
    --- Remove trailing spaces.
    trim_spaces = true,
  }
  return preset
end

---@param autocmds MiNVAutocmds
function M.setup(autocmds)
  local utils = require("utils")
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
