local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVPresetGitsigns
  local preset = {
    setup = {
      current_line_blame = true,
    },
    keymaps = utils.keymap.new({
      ["<Leader>g"] = {
        name = "Git",
        ["j"] = { "<Cmd>Gitsigns next_hunk<CR>", "Goto next hunk" },
        ["k"] = { "<Cmd>Gitsigns prev_hunk<CR>", "Goto prev hunk" },
        ["b"] = { "<Cmd>Gitsigns blame_line<CR>", "Blame line" },
        ["r"] = { "<Cmd>Gitsigns reset_hunk<CR>", "Reset hun" },
        ["R"] = { "<Cmd>Gitsigns reset_buffer<CR>", "Reset buffer" },
        ["s"] = { "<Cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
        ["S"] = { "<Cmd>Gitsigns stage_buffer<CR>", "Stage buffer" },
        ["u"] = { "<Cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" },
        ["p"] = { "<Cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
      },
    }),
    after = utils.callback.new(),
  }
  return preset
end

---@param preset MiNVPresetGitsigns
function M.setup(preset)
  -- Setup gitsigns.
  require("gitsigns").setup(preset.setup)

  -- Set keymaps.
  preset.keymaps:apply()
end

return M
