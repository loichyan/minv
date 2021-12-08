local M = {}

function M.preset()
  ---@class MiNVPresetBufferline
  local preset = {
    show_close_icon = false,
    keymaps = {
      prev = "<S-h>",
      next = "<S-l>",
      close = "<Leader>x",
    },
  }
  return preset
end

---@param preset MiNVPresetBufferline
function M.setup(preset, bufferline)
  local utils = require("utils")

  -- Setup BufferLine.
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
      show_close_icon = preset.show_close_icon,
    },
  })

  -- Set keymaps.
  local keymaps = preset.keymaps
  utils.map("n", keymaps.next, ":BufferLineCycleNext<CR>")
  utils.map("n", keymaps.previous, ":BufferLineCyclePrev<CR>")
  utils.map("n", keymaps.close, ":bdelete<CR>")
end

return M
