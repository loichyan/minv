local M = {}

---@param minv MiNV
---@param extra any[]
function M.setup(minv, extra)
  -- Load plugins.
  require("core.packer").setup({
    function(use)
      -- Packer.
      use({ "wbthomason/packer.nvim" })

      -- Speed up startup time.
      use({ "lewis6991/impatient.nvim" })

      -- Load builtin plugins.
      for _, plug in ipairs(require("builtin").setup(minv)) do
        use(plug)
      end

      -- Load extra plugins.
      for _, plug in ipairs(extra) do
        use(plug)
      end
    end,
    config = {
      display = {
        open_fn = function()
          return require("packer.util").float({ border = minv.settings.border })
        end,
      },
    },
  })
end

return M
