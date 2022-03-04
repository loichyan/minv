local M = {}
---Registered functions.
local _registered_funcs = {}
---Registered keys.
local _registered_keys = {}

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

---Remove a key and return its val.
---@param tbl table
--=@param key any
function M.tbl_remove(tbl, key)
  local val = tbl[key]
  tbl[key] = nil
  return val
end

---@param tbl table
---@param f function
---@return any[]
function M.tbl_to_list(tbl, f)
  local list = {}
  for k, v in pairs(tbl) do
    table.insert(list, f(k, v))
  end
  return list
end

---Create a list with specified size.
---@param size integer
function M.list_new(size)
  local list = {}
  for i = 1, size + 1 do
    table.insert(list, i)
  end
  return list
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

---@param list any[]
---@return table<any, boolean>
function M.list_to_set(list)
  local set = {}
  for _, v in ipairs(list) do
    set[v] = true
  end
  return set
end

---@param set table<any, boolean>
---@return any[]
function M.set_to_list(set)
  return M.tbl_to_list(set, function(k, v)
    if v == true then
      return k
    else
      return nil
    end
  end)
end

-------------
-- Command --
-------------

---Insert `val` to a random position in `tbl`,
---@param tbl table
---@param val any
---@return integer
local function _random_insert(tbl, val)
  -- Look for a new id.
  local id
  repeat
    id = math.random(10000, 99999)
  until tbl[id] == nil
  -- Insert the value.
  tbl[id] = val
  return id
end

---Register function to the global variable.
---@param fn function
---@return integer
function M.register_fn(fn)
  local registered = _registered_funcs
  return _random_insert(registered, fn)
end

---Call registered function.
---@param id integer
function M.call_fn(id, ...)
  _registered_funcs[id](...)
end

---Make command strings.
---@param cmd string|function
---@return string
local function _cmd(cmd)
  return string.format([[lua require("utils").call_fn(%d)]], M.register_fn(cmd))
end

---Auto command.
---@param event string
---@param pat string
---@param cmd string
function M.autocmd(event, pat, cmd)
  if type(cmd) == "function" then
    cmd = _cmd(cmd)
  end
  vim.cmd(string.format("autocmd %s %s %s", event, pat, cmd))
end

------------
-- Keymap --
------------

---Register a `<Plug>` key to the global variable.
function M.register_key()
  local registered = _registered_keys
  local id = _random_insert(registered, true)
  return string.format("<Plug>(_MiNVKeymap#%d)", id)
end

---Iterate over each `lhs`.
---@param lhs string|string[]|nil
function M.foreach_lhs(lhs, f)
  if lhs == nil then
    return
  elseif type(lhs) == "string" then
    f(lhs)
  else
    for _, v in ipairs(lhs) do
      f(v)
    end
  end
end

---@param options table
local function _make_keymap(options)
  local opts = M.tbl_merge({ mode = "n", noremap = true, silent = true }, options)
  local buffer = M.tbl_remove(opts, "buffer")
  local mode = M.tbl_remove(opts, "mode")
  local map = vim.api.nvim_set_keymap
  if opts.buffer ~= nil then
    map = function(...)
      vim.api.nvim_buf_set_keymap(buffer, ...)
    end
  end
  return function(lhs, rhs)
    M.foreach_lhs(lhs, function(l)
      if type(rhs) == "function" then
        rhs = string.format("<Cmd>%s<CR>", _cmd(rhs))
      end
      map(mode, l, rhs, opts)
    end)
  end
end

---Set keymaps.
---@param input table
function M.keymaps(input)
  local opts = {}
  local mappings = {}
  for key, val in pairs(input) do
    if type(key) == "number" then
      table.insert(mappings, val)
    elseif type(key) == "string" then
      opts[key] = val
    end
  end
  local keymap = _make_keymap(opts)
  for _, mapping in ipairs(mappings) do
    keymap(mapping[1], mapping[2])
  end
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

return M
