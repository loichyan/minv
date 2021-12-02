----------------------
-- Type definitions --
----------------------

local M = {}

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
function M.au(event, pat, cmd)
  vim.cmd(string.format("au %s %s %s", event, pat, cmd))
end

--- Set keymap.
---@param mode string|string[]
---@param lhs string|string[]
---@param rhs string
---@param opts table|nil
function M.map(mode, lhs, rhs, opts)
  -- Merge options.
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
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

return M
