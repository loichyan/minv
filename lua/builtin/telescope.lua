local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVPresetTree
  local preset = {
    after = utils.callback.new(),
    keymaps = {
      prompt = utils.keymap.new({
        ["<S-j><S-k>"] = "<Esc><Cmd>close!<CR>",
        ["<S-k><S-j>"] = "<Esc><Cmd>close!<CR>",
      }),
      normal = utils.keymap.new({
        ["<Leader>f"] = {
          name = "Find",
          ["f"] = { "<Cmd>Telescope live_grep<CR>", "Strings" },
          ["m"] = { "<Cmd>Telescope marks<CR>", "Marks" },
          ["b"] = { "<Cmd>Telescope buffers<CR>", "Buffers" },
          ["r"] = { "<Cmd>Telescope registers<CR>", "Registers" },
          ["g"] = { "<Cmd>Telescope git_commits<CR>", "Git commits" },
          ["n"] = { "<Cmd>Telescope notify<CR>", "Notifications" },
        },
      }),
    },
    extensions = utils.set.new({
      "fzf",
    }),
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
  for _, ext in ipairs(preset.extensions:to_list()) do
    telescope.load_extension(ext)
  end

  -- Set mappings in TelescopePrompt.
  utils.autocmd("FileType", "TelescopePrompt", function()
    preset.keymaps.prompt:apply({
      mode = "i",
      buffer = vim.api.nvim_get_current_buf(),
    })
  end)

  -- Set mappings for telescope commands.
  preset.keymaps.normal:apply()
end
return M
