local M = {}

function M.preset()
  ---@class MiNVSettings
  local preset = {
    -- Window
    border = "rounded",
    -- Leader
    leader = " ",
    markdown_highlight = {
      "bash",
      "c",
      "json",
      "lua",
      "python",
      "sh",
    },
    -- General
    clipboard = "unnamed",
    mouse = "a",
    timeoutlen = 200,
    updatetime = 300,
    -- Space
    expandtab = true,
    smartindent = true,
    tabstop = 4,
    shiftwidth = 4,
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

---@param minv MiNV
function M.setup(minv)
  local settings = minv.settings

  -- Apply options
  local g = {
    mapleader = settings.leader,
    markdown_fenced_languages = settings.markdown_highlight,
  }
  local o = {
    -- General
    clipboard = settings.clipboard,
    mouse = settings.mouse,
    timeoutlen = settings.timeoutlen,
    updatetime = settings.updatetime,
    -- Spaces
    tabstop = settings.tabstop,
    shiftwidth = settings.shiftwidth,
    -- Search
    hlsearch = settings.hlsearch,
    ignorecase = settings.ignorecase,
    smartcase = settings.smartcase,
    -- File
    swapfile = settings.swapfile,
    undofile = settings.undofile,
    -- Line number
    number = settings.number,
    relativenumber = settings.relativenumber,
    -- Space
    expandtab = true,
    smartindent = true,
    -- UI
    hidden = true,
    title = true,
    signcolumn = "yes",
    termguicolors = true,
    showmode = false,
    -- Window
    splitbelow = true,
    splitright = true,
  }
  for k, v in pairs(g) do
    vim.g[k] = v
  end
  for k, v in pairs(o) do
    vim.o[k] = v
  end
end

return M
