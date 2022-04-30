local M = {}

---@param minv MiNV
---@param plugins any[]
function M.setup(minv, plugins)
  -- Load plugins.
  require("minv.core.packer").setup({
    function(use)
      -- Load plugins.
      for _, plug in ipairs(plugins) do
        use(plug)
      end
    end,
    config = minv.builtin.packer,
  })
end

return M
