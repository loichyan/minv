local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVPresetBufferline
  local preset = {
    setup = {
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
        show_tab_indicators = true,
        show_close_icon = false,
      },
    },
    keymaps = {
      prev = "<S-h>",
      next = "<S-l>",
      close = "<Leader>x",
    },
    after = utils.callback.new(),
  }
  return preset
end

---@param preset MiNVPresetBufferline
function M.setup(preset)
  local bufferline = require("bufferline")
  local utils = require("utils")

  -- Setup BufferLine.
  bufferline.setup(preset.setup)

  -- Set keymaps.
  local keymaps = preset.keymaps
  utils.keymaps({
    { keymaps.next, "<Cmd>BufferLineCycleNext<CR>" },
    { keymaps.prev, "<Cmd>BufferLineCyclePrev<CR>" },
    { keymaps.close, "<Cmd>bdelete<CR>" },
  })
end

return M
