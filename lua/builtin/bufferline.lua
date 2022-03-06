local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVPresetBufferline
  local preset = {
    after = utils.callback.new(),
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
    keymaps = utils.keymap.new({
      ["<S-h>"] = "<Cmd>BufferLineCyclePrev<CR>",
      ["<S-l>"] = "<Cmd>BufferLineCycleNext<CR>",
      ["<Leader>x"] = "<Cmd>bdelete<CR>",
    }),
  }
  return preset
end

---@param preset MiNVPresetBufferline
function M.setup(preset)
  -- Setup BufferLine.
  require("bufferline").setup(preset.setup)

  -- Set keymaps.
  preset.keymaps:apply()
end

return M
