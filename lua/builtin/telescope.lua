local M = {}

function M.setup(_)
  local telescope = require("telescope")

  -- Setup telescope.
  telescope.setup({
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })

  -- Laad extensions.
  telescope.load_extension("fzf")
  telescope.load_extension("projects")
end
return M
