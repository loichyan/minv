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
  local set_map = utils.register_fn(function()
    local map = utils.make_buf_map(0)
    map("i", preset.keymaps.close, "<Esc><Cmd>close!<CR>")
  end)
  local cmd = string.format([[lua require("utils").call_fn(%d)]], set_map)
  utils.autocmd("FileType", "TelescopePrompt", cmd)
end
return M
