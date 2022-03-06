local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVSettings
  local preset = {
    -- Leader
    leader = " ",
    markdown_highlight = utils.set.new({
      "bash",
      "c",
      "json",
      "lua",
      "python",
      "sh",
    }),
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

---@param preset MiNVSettings
function M.setup(preset)
  local utils = require("utils")

  -- Apply options
  utils.g({
    mapleader = preset.leader,
    markdown_fenced_languages = preset.markdown_highlight:to_list(),
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
  })

  -- Reserved options
  utils.o({

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
