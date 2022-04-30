local M = {}

function M.preset()
  return {
    g = {
      -- Leader
      mapleader = " ",
      -- Markdown highlight languages
      markdown_fenced_languages = {
        "bash",
        "c",
        "json",
        "lua",
        "python",
        "sh",
      },
    },
    o = {
      -- General
      clipboard = "unnamed",
      mouse = "a",
      timeoutlen = 300,
      updatetime = 300,
      autoread = true,
      -- Space
      expandtab = true,
      tabstop = 4,
      shiftwidth = 4,
      autoindent = true,
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
      -- UI
      hidden = true,
      title = true,
      signcolumn = "yes",
      termguicolors = true,
      showmode = false,
      -- Window
      splitbelow = true,
      splitright = true,
    },
  }
end

---@param minv MiNV
function M.setup(minv)
  local preset = minv.settings
  for k, v in pairs(preset.g) do
    vim.g[k] = v
  end
  for k, v in pairs(preset.o) do
    vim.o[k] = v
  end
end

return M
