local register = require("minv.utils.register")
local keybinding = require("minv.utils.keybinding")
local M = {
  Keybinding = keybinding.new,
  PluginGroup = require("minv.utils.plugin_group").new,
  register_key = register.register_key,
}

---@generic T
---@param list T[]
---@return table<T,boolean>
function M.list_to_set(list)
  local set = {}
  for _, val in ipairs(list) do
    set[val] = true
  end
  return set
end

---Auto command.
---@param event string|table
---@param pat string|table
---@param cmd string|function
function M.autocmd(event, pat, cmd)
  local opts = {
    pattern = pat,
  }
  if type(cmd) == "string" then
    opts.command = cmd
  elseif type(cmd) == "function" then
    opts.callback = cmd
  end
  vim.api.nvim_create_autocmd(event, opts)
end

return M
