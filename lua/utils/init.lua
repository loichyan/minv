----------------------
-- Type definitions --
----------------------

local M = {}

--- Set keymap.
---@param mode string
---@param lhs string
---@param rhs string
---@param opts table|nil
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--- Set keymaps.
---@param maps table<string, any[]>
function M.keymaps(maps)
  for _, m in pairs(maps) do
    M.map(m[1], m[2], m[3], m[4])
  end
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
function M.au(event, pat, cmd)
  vim.cmd(string.format("au %s %s %s", event, pat, cmd))
end

--- Auto commands.
---@param au table<string, any[]>
function M.autocmds(au)
  for _, a in pairs(au) do
    M.au(a[1], a[2], a[3])
  end
end

return M
