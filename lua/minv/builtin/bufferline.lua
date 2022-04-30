local M = {}

function M.preset()
  return {
    numbers = "none",
    diagnostics = "nvim_lsp",
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "thin",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = "directory",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "left",
      },
    },
  }
end

---@param minv MiNV
function M.setup(minv)
  require("bufferline").setup({
    options = minv.builtin.bufferline,
  })
end

return M
