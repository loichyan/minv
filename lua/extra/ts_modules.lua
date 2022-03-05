local M = {}

function M.preset()
  ---@class MiNVPresetTSModules
  local preset = {
    textobjects = {
      enable = true,
      setup = {
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
    },
  }
  return preset
end

---@param preset MiNVPresetTSModules
---@param minv MiNV
function M.setup(preset, minv)
  -- Load modules.
  if preset.textobjects.enable then
    minv.builtin.treesitter.modules.textobjects = preset.textobjects.setup
  end
end

return M
