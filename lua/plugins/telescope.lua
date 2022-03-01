local M = {}

function M.preset()
  ---@class MiNVPresetTree
  local preset = {
    keymaps = {
      close = { "<S-j><S-k>", "<S-k><S-j>" },
      live_grep = "<Leader>ff",
      marks = "<Leader>fm",
      buffers = "<Leader>fb",
      registers = "<Leader>fr",
      git_commits = "<Leader>fg",
      notify = "<Leader>fn",
    },
  }
  return preset
end

---@param preset MiNVPresetTree
function M.setup(preset)
  local telescope = require("telescope")
  local utils = require("utils")

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

  -- Set mappings for telescope commands.
  utils.keymaps({
    { keymaps.live_grep, "<Cmd>Telescope live_grep<CR>" },
    { keymaps.marks, "<Cmd>Telescope marks<CR>" },
    { keymaps.buffers, "<Cmd>Telescope buffers<CR>" },
    { keymaps.registers, "<Cmd>Telescope registers<CR>" },
    { keymaps.git_commits, "<Cmd>Telescope git_commits<CR>" },
    { keymaps.notify, "<Cmd>Telescope notify<CR>" },
  })
end
return M
