local M = {}

---@param builtin MiNVBuiltin
---@param extra table[]|nil
function M.setup(builtin, extra)
  local packer = require("core.packer").setup(_MINV.builtin.packer)

  -- Load plugins.
  packer.startup(function(use)
    -- Packer
    use({ "wbthomason/packer.nvim" })
    -- Speed up
    use({ "lewis6991/impatient.nvim" })
    use({ "nathom/filetype.nvim" })
    -- Builtin plugins
    for _, plug in ipairs(require("builtin").setup(builtin)) do
      use(plug)
    end
    -- Extra plugins
    for _, plug in ipairs(extra) do
      use(plug)
    end
  end)
end

return M
