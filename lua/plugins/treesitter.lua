local M = {}

function M.preset()
  ---@class MiNVPresetTreesitter
  local preset = {
    install = {
      "bash",
      "c",
      "json",
      "lua",
      "python",
    },
    modules = {
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
  local setup = {
    ensure_installed = preset.install,
  }
  for k, v in pairs(preset.modules) do
    setup[k] = v
  end
  treesitter.setup(setup)
end

return M
