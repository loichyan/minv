local M = {}

function M.preset()
  ---@class MiNVSettings
  local preset = {
    -- Global
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
  local preset = minv.settings

  -- Apply options
  local g = {
    mapleader = preset.leader,
    markdown_fenced_languages = preset.markdown_highlight,
  }
  local o = {
    -- General
    clipboard = preset.clipboard,
    mouse = preset.mouse,
    timeoutlen = preset.timeoutlen,
    updatetime = preset.updatetime,
    -- Spaces
    tabstop = preset.tabstop,
    shiftwidth = preset.shiftwidth,
    -- Search
    hlsearch = preset.hlsearch,
    ignorecase = preset.ignorecase,
    smartcase = preset.smartcase,
    -- File
    swapfile = preset.swapfile,
    undofile = preset.undofile,
    -- Line number
    number = preset.number,
    relativenumber = preset.relativenumber,
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
