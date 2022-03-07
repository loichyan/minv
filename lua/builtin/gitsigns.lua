local M = {}

---@param minv MiNV
function M.setup(minv)
  -- Setup gitsigns.
  require("gitsigns").setup({
    current_line_blame = true,
  })
end

return M
