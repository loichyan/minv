local M = {}

function M.preset()
  ---@class MiNVAutocmds
  local preset = {
    --- Hightlight yanked text.
    hl_yank = {
      highgroup = "Search",
      timeout = 200,
    },
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

  if autocmds.hl_yank ~= nil then
    utils.autocmd(
      "TextYankPost",
      "*",
      string.format(
        [[lua require("vim.highlight").on_yank({higroup = "%s", timeout = %d})]],
        autocmds.hl_yank.highgroup,
        autocmds.hl_yank.timeout
      )
    )
  end
  au(autocmds.trim_spaces, "BufWritePre", "*", [[:%s/\s\+$//e]])
end

return M
