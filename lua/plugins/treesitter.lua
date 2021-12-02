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
        extended_mode = true,
        --- Fluent colors.
        colors = {
          "#E74856",
          "#0078D7",
          "#0099BC",
          "#6B69D6",
          "#00CC6A",
          "#F7630C",
          "#FFB900",
        },
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
