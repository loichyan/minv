local M = {}

function M.preset()
  ---@class MiNVSettings
  local preset = {
    -- Leader
    leader = " ",
    markdown_highlight = {
      ["bash"] = true,
      ["c"] = true,
      ["json"] = true,
      ["lua"] = true,
      ["python"] = true,
    },
    -- General
    clipboard = "unnamed",
    mouse = "a",
    timeoutlen = 300,
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

---@param preset MiNVSettings
function M.setup(preset)
  local utils = require("utils")
  local markdown_highlight = utils.set_to_list(preset.markdown_highlight)

  --------------------
  -- Public options --
  --------------------

  utils.g({
    mapleader = preset.leader,
    markdown_fenced_languages = markdown_highlight,
  })
  utils.o({
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
    relativenumber = preset.relativenumber,

    ---------------------
    -- Private options --
    ---------------------

    -- Line number
    number = true,
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
  })
end

return M
