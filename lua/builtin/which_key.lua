local M = {}

---@param minv MiNV
function M.setup(minv)
  local which_key = require("which-key")
  local preset = minv.builtin.which_key
  which_key.setup({
    operators = preset.operators,
    triggers = preset.triggers,
    ignore_missing = preset.ignore_missing,
  })
  local groups = {}
  for key, name in pairs(preset.groups) do
    groups[key] = { name = name }
  end
  which_key.register(groups)
end

return M
