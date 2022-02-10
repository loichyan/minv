local M = {}

function M.preset()
  ---@class MiNVPresetTree
  local preset = {
    keymaps = {
      close = { "<S-j><S-k>", "<S-k><S-j>" },
    },
  }
  return preset
end

---@param preset MiNVPresetTree
function M.setup(preset)
  local telescope = require("telescope")
  local utils = require("utils")

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
  telescope.load_extension("fzf")

  -- Set mappings in TelescopePrompt.
  local keymaps = preset.keymaps
  utils.autocmd("FileType", "TelescopePrompt", function()
    utils.keymaps({
      mode = "i",
      buffer = vim.api.nvim_get_current_buf(),
      { keymaps.close, "<Esc><Cmd>close!<CR>" },
    })
  end)
end
return M
