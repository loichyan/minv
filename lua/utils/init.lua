local others = require("utils.others")
local M = {
  set = require("utils.set"),
  callback = require("utils.callback"),
  keymap = require("utils.keymap"),
  register_key = others.register_key,
}

-----------
-- Table --
-----------

---Merge tables.
---@return table
function M.tbl_merge(...)
  local merged = {}
  for _, rhs in ipairs({ ... }) do
    if rhs ~= nil then
      merged = vim.tbl_extend("force", merged, rhs)
    end
  end
  return merged
end

---@param list any[]
---@return any[]
function M.list_map(list, f)
  local mapped = {}
  for _, v in ipairs(list) do
    table.insert(mapped, f(v))
  end
  return mapped
end

-----------------
-- VIM Options --
-----------------

---Set Vim options.
---@param opts table<string, any>
function M.o(opts)
  for k, v in pairs(opts) do
    vim.o[k] = v
  end
end

---Set Vim globals.
---@param vars table<string, any>
function M.g(vars)
  for k, v in pairs(vars) do
    vim.g[k] = v
  end
end

------------
-- Others --
------------

---Auto command.
---@param event string
---@param pat string
---@param cmd string
function M.autocmd(event, pat, cmd)
  if type(cmd) == "function" then
    cmd = others.cmd(cmd)
  end
  vim.cmd(string.format("autocmd %s %s %s", event, pat, cmd))
end

---Set keymaps.
---@param mappings table[]
function M.keymaps(mappings, opts)
  local mappings2 = {}
  for _, m in ipairs(mappings) do
    local lhs, rhs = table.unpack(m)
    if type(lhs) == "table" then
      for _, l in ipairs(lhs) do
        mappings2[l] = rhs
      end
    else
      mappings2[lhs] = rhs
    end
  end
  M.keymap.set(mappings2, opts)
end

return M
