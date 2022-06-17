local M = {}

function M.preset()
  return {
    defaults = {},
    pickers = {},
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  }
end

---@param minv MiNV
function M.setup(minv)
  local telescope = require("telescope")

  -- Setup telescope.
  telescope.setup(minv.plugins.telescope.config)

  -- Laad extensions.
  telescope.load_extension("fzf")
end
return M
