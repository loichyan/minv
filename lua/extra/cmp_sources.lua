local M = {}

function M.preset()
  ---@class MiNVPresetAutopairs
  local preset = {
    nvim_lsp_signature_help = {
      enable = true,
    },
  }
  return preset
end

---@param preset MiNVPresetAutopairs
---@param minv MiNV
function M.apply(preset, minv)
  -- Load cmp sources.
  if preset.nvim_lsp_signature_help.enable then
    minv.builtin.cmp.sources["nvim_lsp_signature_help"] = 5
  end
end

return M
