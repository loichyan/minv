local M = {}

function M.preset()
  ---@class MiNVPresetTreesitter
  local preset = {
    install = {
      ["bash"] = true,
      ["c"] = true,
      ["json"] = true,
      ["lua"] = true,
      ["python"] = true,
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
    },
  }
  return preset
end

---@param preset MiNVPresetTreesitter
function M.setup(preset, treesitter)
  local utils = require("utils")
  local setup = {
    ensure_installed = utils.set_to_list(preset.install),
  }
  for k, v in pairs(preset.modules) do
    setup[k] = v
  end
  treesitter.setup(setup)
end

return M
