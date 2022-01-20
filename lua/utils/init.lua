local M = {
  --- Registered functions.
  _registered_funcs = {},
  --- Registered keys.
  _registered_keys = {},
}

--- Merge two tables.
---@param lhs table
---@param rhs table
---@return table
function M.tbl_merge(lhs, rhs)
  return vim.tbl_extend("force", lhs, rhs)
end

--- Set Vim options.
---@param opts table<string, any>
function M.o(opts)
  for k, v in pairs(opts) do
    vim.o[k] = v
  end
end

--- Set Vim globals.
---@param vars table<string, any>
function M.g(vars)
  for k, v in pairs(vars) do
    vim.g[k] = v
  end
end

--- Auto command.
---@param event string
---@param pat string
---@param cmd string
function M.autocmd(event, pat, cmd)
  vim.cmd(string.format("autocmd %s %s %s", event, pat, cmd))
end

--- Flatten modes and lhs values.
---@param mode string|string[]
---@param lhs string|string[]|nil
---@param f function
function M.flatten_mode_lhs(mode, lhs, f)
  -- Flatten modes.
  local modes = {}
  if type(mode) == "table" then
    for _, m in pairs(mode) do
      table.insert(modes, m)
    end
  else
    table.insert(modes, mode)
  end
  -- Flatten lhs values.
  local lhs_vals = {}
  if type(lhs) == "table" then
    for _, l in pairs(lhs) do
      table.insert(lhs_vals, l)
    end
  else
    table.insert(lhs_vals, lhs)
  end
  -- Callback.
  for _, m in pairs(modes) do
    for _, l in pairs(lhs_vals) do
      f(m, l)
    end
  end
end

--- Set keymap.
---@param map function
local function _make_map(map)
  --- Set keymap.
  ---@param mode string|string[]
  ---@param lhs string|string[]|nil
  ---@param rhs string
  ---@param opts table|nil
  local function _map(mode, lhs, rhs, opts)
    if lhs == nil then
      return
    end
    -- Merge options.
    local options = { noremap = true, silent = true }
    if opts ~= nil then
      options = M.tbl_merge(options, opts)
    end
    -- Set keymap.
    M.flatten_mode_lhs(mode, lhs, function(m, l)
      map(m, l, rhs, options)
    end)
  end
  return _map
end

local _map = _make_map(vim.api.nvim_set_keymap)
--- Set global mappings.
function M.map(...)
  _map(...)
end

--- Return a funtion sets buffer-local mappings.
function M.make_buf_map(buf)
  return _make_map(function(...)
    vim.api.nvim_buf_set_keymap(buf, ...)
  end)
end

--- Insert `val` to a random position in `tbl`,
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

--- Register function to the global variable.
---@param fn function
---@return integer
function M.register_fn(fn)
  local registered = M._registered_funcs
  return _random_insert(registered, fn)
end

--- Call registered function.
---@param id integer
function M.call_fn(id, ...)
  M._registered_funcs[id](...)
end

--- Register a `<Plug>` key to the global variable.
function M._register_key()
  local registered = M._registered_keys
  local id = _random_insert(registered, true)
  return string.format("<Plug>(_MiNVKeymap#%d)", id)
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

---@param tbl table
---@param f function|nil
---@return table
function M.tbl_map(tbl, f)
  local mapped = {}
  for k, v in pairs(tbl) do
    local k2, v2 = f(k, v)
    mapped[k2] = v2
  end
  return mapped
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

return M
