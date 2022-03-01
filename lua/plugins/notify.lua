local M = {}

function M.preset()
  ---@class MiNVPresetNotify
  local preset = {
    setup = {
      max_width = 70,
    },
  }
  return preset
end

---@param preset MiNVPresetNotify
function M.setup(preset)
  local notify = require("notify")
  notify.setup(preset.setup)
  vim.notify = notify
end

return M
