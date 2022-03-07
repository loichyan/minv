local M = {}

---@param minv MiNV
function M.setup(minv)
  local offsets = {
    {
      filetype = "NvimTree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "left",
    },
  }
  for _, offs in ipairs(minv.builtin.bufferline.offsets) do
    table.insert(offsets, offs)
  end

  -- Setup BufferLine.
  require("bufferline").setup({
    options = {
      diagnostics = "nvim_lsp",
      offsets = offsets,
      show_tab_indicators = true,
      show_close_icon = false,
    },
  })
end

return M
