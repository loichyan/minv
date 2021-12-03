local M = {}

--- Merge two tables.
---@param lhs table
---@param rhs table
---@return table
function M.merge(lhs, rhs)
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
  vim.cmd(string.format("au %s %s %s", event, pat, cmd))
end

--- Set keymap.
---@param handler function
local function _make_map(handler)
  --- Set keymap.
  ---@param mode string|string[]
  ---@param lhs string|string[]|nil
  ---@param rhs string
  ---@param opts table|nil
  local function f(mode, lhs, rhs, opts)
    if lhs == nil then
      return
    end
    -- Merge options.
    local options = { noremap = true, silent = true }
    if opts ~= nil then
      options = M.merge(options, opts)
    end
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
    -- Set keymap.
    for _, m in pairs(modes) do
      for _, l in pairs(lhs_vals) do
        vim.api.nvim_set_keymap(m, l, rhs, options)
      end
    end
  end
  return f
end

M.map = _make_map(vim.api.nvim_set_keymap)

function M.make_buf_map(buf)
  return _make_map(function(...)
    vim.api.nvim_buf_set_keymap(buf, ...)
  end)
end

local function _random_id()
  return math.random(10000, 99999)
end

--- Register function to the global variable.
---@param fn function
---@return integer
function M._register_fn(fn)
  local registered = _MINV._registered_funcs
  -- Look for a new id.
  local id
  repeat
    id = _random_id()
  until registered[id] == nil
  -- Insert the functions.
  registered[id] = fn
  return id
end

--- Call registered function.
---@param id integer
function M._call_fn(id)
  _MINV._registered_funcs[id]()
end

return M
