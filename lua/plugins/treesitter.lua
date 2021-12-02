local M = {}

function M.preset()
  ---@class MiNVPresetTreesitter
  local preset = {
    setup = {
      ensure_installed = {
        "bash",
        "c",
        "json",
        "lua",
        "python",
      },
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      matchup = {
        enable = true,
      },
      rainbow = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
      },
    },
  }
  return preset
end

---@param preset MiNVPresetTreesitter
function M.setup(treesitter, preset)
  treesitter.setup(preset.setup)
end

return M
