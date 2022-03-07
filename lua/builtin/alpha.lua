local M = {}

---@param minv MiNV
function M.setup(minv)
  local dashboard = require("alpha.themes.dashboard")

  -- Load UI elements.
  local buttons = {}
  for _, val in ipairs(minv.builtin.dashboard.buttons) do
    table.insert(buttons, dashboard.button(table.unpack(val)))
  end
  dashboard.section.buttons.val = buttons
  dashboard.section.header.val = minv.builtin.dashboard.header()
  dashboard.section.footer.val = minv.builtin.dashboard.footer()

  -- Setup alpha.
  require("alpha").setup(dashboard.config)
end

return M
