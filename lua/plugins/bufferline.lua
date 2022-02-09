local M = {}

function M.preset()
  ---@class MiNVPresetBufferline
  local preset = {
    options = {
      show_close_icon = false,
    },
    keymaps = {
      prev = "<S-h>",
      next = "<S-l>",
      close = "<Leader>x",
    },
  }
  return preset
end

---@param preset MiNVPresetBufferline
function M.setup(preset)
  local bufferline = require("bufferline")
  local utils = require("utils")

  -- Setup BufferLine.
  local opts = preset.options
  bufferline.setup({
    options = {
      diagnostics = "nvim_lsp",
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
      show_close_icon = opts.show_close_icon,
    },
  })

  -- Set keymaps.
  local keymaps = preset.keymaps
  utils.keymaps({
    { keymaps.next, "<Cmd>BufferLineCycleNext<CR>" },
    { keymaps.prev, "<Cmd>BufferLineCyclePrev<CR>" },
    { keymaps.close, "<Cmd>bdelete<CR>" },
  })
end

return M
