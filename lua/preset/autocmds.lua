local M = {}

function M.preset()
  ---@class MiNVAutocmds
  local preset = {
    --- Hightlight yanked text.
    hl_yank = {
      highgroup = "Search",
      timeout = 200,
    },
    --- Format on save.
    format_on_save = {
      timeout = nil,
    },
    --- Remove trailing spaces.
    trim_spaces = true,
  }
  return preset
end

---@param autocmds MiNVAutocmds
function M.setup(autocmds)
  local utils = require("utils")
  local function au(enable, ...)
    if enable then
      utils.autocmd(...)
    end
  end

  if autocmds.hl_yank ~= nil then
    local cmd = string.format(
      [[lua require("vim.highlight").on_yank({higroup = "%s", timeout = %d})]],
      autocmds.hl_yank.highgroup,
      autocmds.hl_yank.timeout
    )
    utils.autocmd("TextYankPost", "*", cmd)
  end
  if autocmds.format_on_save ~= nil then
    local cmd = string.format([[:silent lua vim.lsp.buf.formatting_sync(nil, %s)]], autocmds.format_on_save.timeout)
    utils.autocmd("BufWritePre", "*", cmd)
  end
  au(autocmds.trim_spaces, "BufWritePre", "*", [[:silent %s/\s\+$//e]])
end

return M
