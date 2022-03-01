local M = {}

function M.preset()
  ---@class MiNVPresetTodo
  local preset = {
    setup = {},
  }
  return preset
end

---@param preset MiNVPresetTodo
function M.setup(preset)
  require("todo-comments").setup(preset.setup)
end

return M
