local M = {}

function M.preset()
  ---@class MiNVSettings
  local preset = {
    -- Leader
    mapleader = " ",
    -- General
    clipboard = "unnamed",
    mouse = "a",
    timeoutlen = 500,
    -- UI
    hidden = true,
    title = true,
    signcolumn = "yes",
    termguicolors = true,
    showmode = false,
    -- Space
    expandtab = true,
    tabstop = 4,
    shiftwidth = 4,
    smartindent = true,
    -- Window
    splitbelow = true,
    splitright = true,
    -- Search
    hlsearch = true,
    ignorecase = true,
    smartcase = true,
    -- File
    swapfile = false,
    undofile = true,
    -- Line number
    number = true,
    relativenumber = true,
  }
  return preset
end

---@param settings MiNVSettings
function M.setup(settings)
  local preset = M.preset()
  local globals = { "mapleader" }
  -- Set Vim globals.
  for _, k in pairs(globals) do
    vim.g[k] = settings[k]
    preset[k] = nil
  end
  -- Set Vim options.
  for k in pairs(preset) do
    vim.o[k] = settings[k]
  end
end

return M
