local M = {}

function M.preset()
  ---@class MiNVPresetTodoComments
  local preset = {
    enable = true,
    setup = {},
    after = nil,
  }
  return preset
end

---@param preset MiNVPresetTodoComments
function M.setup(preset)
  -- Setup todo-comments.
  require("todo-comments").setup(preset.setup)
end

return M
