local M = {}

function M.preset()
  ---@class MiNVPresetNotify
  local preset = {
    enable = true,
    setup = {
      max_width = 70,
    },
    after = nil,
  }
  return preset
end

---@param preset MiNVPresetNotify
function M.setup(preset)
  local notify = require("notify")

  -- Setup notify
  notify.setup(preset.setup)
  vim.notify = notify
end

return M
