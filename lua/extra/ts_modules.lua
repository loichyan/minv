local M = {}

function M.preset()
  ---@class MiNVPresetTSModules
  local preset = {
    textobjects = {
      enable = true,
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      ---Fluent colors.
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
  }
  return preset
end

---@param preset MiNVPresetTSModules
---@param minv MiNV
function M.apply(preset, minv)
  -- Load modules.
  if preset.textobjects.enable then
    minv.builtin.treesitter.modules.textobjects = preset.textobjects
  end
  if preset.rainbow.enable then
    minv.builtin.treesitter.modules.rainbow = preset.rainbow
  end
end

return M
