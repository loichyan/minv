local M = {}

function M.preset()
  ---@class MiNVPresetBuffer
  local preset = {
    keymaps = {
      previous = "<S-h>",
      next = "<S-l>",
      close = "<Leader>x",
    },
  }
  return preset
end

---@param preset MiNVPresetBuffer
function M.setup(preset, bufferline)
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
      show_close_icon = false,
    },
  })
  local utils = require("utils")
  local keymaps = preset.keymaps
  utils.map("n", keymaps.next, ":BufferLineCycleNext<CR>")
  utils.map("n", keymaps.previous, ":BufferLineCyclePrev<CR>")
  utils.map("n", keymaps.close, ":bdelete<CR>")
end

return M
