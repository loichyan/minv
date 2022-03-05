local M = {}

function M.preset()
  ---@class MiNVPresetAutopairs
  local preset = {
    enable = true,
    setup = {
      check_ts = true,
    },
    after = nil,
  }
  return preset
end

---@param preset MiNVPresetAutopairs
function M.setup(preset)
  -- Setup autopairs.
  require("nvim-autopairs").setup(preset.setup.autopairs)
  require("cmp").event:on(
    "confirm_done",
    require("nvim-autopairs.completion.cmp").on_confirm_done()
  )
end

return M
