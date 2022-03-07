local register = require("utils.register")
local keybinding = require("utils.keybinding")
local M = {
  Keybinding = keybinding.new,
  register_key = register.register_key,
}

---@param bindings table<string,string|any[]|table<string,string|any[]>>
---@param options table<string,boolean>
function M.set_keybindings(bindings, options)
  keybinding.new(bindings):apply(true, nil, options)
end

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
---@param event string
---@param pat string
---@param cmd string|function
function M.autocmd(event, pat, cmd)
  if type(cmd) == "function" then
    cmd = register.cmd(cmd)
  end
  if type(cmd) == "string" then
    vim.cmd(string.format("autocmd %s %s %s", event, pat, cmd))
  end
end

return M
