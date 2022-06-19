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

  minv.keybindings.telescope:apply({
    ["telescope.files"] = {
      "<Cmd>Telescope find_files<CR>",
      "Search files",
    },
    ["telescope.grep"] = {
      "<Cmd>Telescope live_grep<CR>",
      "Search strings",
    },
    ["telescope.marks"] = { "<Cmd>Telescope marks<CR>", "Search marks" },
    ["telescope.buffers"] = {
      "<Cmd>Telescope buffers<CR>",
      "Search buffers",
    },
    ["telescope.registers"] = {
      "<Cmd>Telescope registers<CR>",
      "Search registers",
    },
    ["telescope.git_commits"] = {
      "<Cmd>Telescope git_commits<CR>",
      "Search git commits",
    },
    ["telescope.recent_files"] = {
      "<Cmd>Telescope oldfiles<CR>",
      "Search recent files",
    },
    ["telescope.document_symbols"] = {
      "<Cmd>Telescope lsp_document_symbols<CR>",
      "Search document symbols",
    },
    ["telescope.workspace_symbols"] = {
      "<Cmd>Telescope lsp_workspace_symbols<CR>",
      "Search workspace symbols",
    },
  })
end

return M
