local M = {}

---@param minv MiNV
function M.setup(minv)
  local components = {
    mode = {
      function()
        return " "
      end,
      padding = { left = 1, right = 1 },
    },
    branch = { "branch" },
    filename = { "filename" },
    diff = { "diff" },
    diagnostics = { "diagnostics", sources = { "nvim_diagnostic" } },
    encoding = { "encoding", fmt = string.upper },
    fileformat = { "fileformat" },
    filetype = { "filetype", fmt = string.upper },
    progress = { "progress" },
  }

  local extensions = {
    "nvim-tree",
    "toggleterm",
    "quickfix",
  }
  for _, ext in ipairs(minv.builtin.lualine.extensions) do
    table.insert(extensions, ext)
  end

  -- Setup lualine.
  require("lualine").setup({
    options = {
      theme = "auto",
    },
    sections = {
      lualine_a = {
        components.mode,
      },
      lualine_b = {
        components.branch,
        components.filename,
      },
      lualine_c = {
        components.diff,
      },
      lualine_x = {
        components.diagnostics,
      },
      lualine_y = {
        components.encoding,
        components.fileformat,
        components.filetype,
      },
      lualine_z = {
        components.progress,
      },
    },
    extensions = extensions,
  })
end

return M
