local M = {}

function M.preset()
  ---@class MiNVPlugPacker
  local preset = {
    init = {
      display = {
        open_fn = function()
          return require("packer.util").float({ border = "single" })
        end,
        prompt_border = "single",
      },
    },
  }
  return preset
end

---@param packer MiNVPlugPacker
function M.setup(plug, packer)
  plug.init(packer.init)
end

return M
