local M = {}

function M.preset()
  ---@class MiNVPresetTreesitter
  local preset = {
    setup = {
      ensure_installed = {
        "bash",
        "c",
        "javascript",
        "json",
        "lua",
        "python",
        "rust",
        "toml",
        "yaml",
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
function M.setup(plug, preset)
  plug.setup(preset.setup)
end

return M
