local M = {}

---@param minv MiNV
function M.setup(minv)
  local packer = require("core.packer").setup(_MINV.builtin.packer)

  -- Load plugins.
  packer.startup(function(use)
    -- Packer.
    use({ "wbthomason/packer.nvim" })

    -- Speed up startup time.
    use({ "lewis6991/impatient.nvim" })
    use({ "nathom/filetype.nvim" })

    -- Load builtin plugins.
    for _, plug in ipairs(require("builtin").setup(minv.builtin)) do
      use(plug)
    end

    -- Load extra plugins.
    for _, plug in ipairs(minv.extra) do
      use(plug)
    end
  end)
end

return M
