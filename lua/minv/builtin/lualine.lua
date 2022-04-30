local M = {}

function M.preset()
  return {
    options = {
      theme = "auto",
      section_separators = "",
      component_separators = "│",
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        {
          function()
            return " "
          end,
        },
      },
      lualine_b = {
        { "branch" },
      },
      lualine_c = {
        { "diff" },
        { "diagnostics", sources = { "nvim_diagnostic" } },
      },
      lualine_x = {
        { "encoding", fmt = string.upper },
        { "fileformat" },
        { "filetype" },
      },
      lualine_y = {
        { "progress" },
      },
      lualine_z = {
        { "location" },
      },
    },
    extensions = {
      "nvim-tree",
      "toggleterm",
      "quickfix",
    },
  }
end

---@param minv MiNV
function M.setup(minv)
  require("lualine").setup(minv.builtin.lualine)
end

return M
