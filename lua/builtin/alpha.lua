local M = {}

---@param minv MiNV
function M.setup(minv)
  local dashboard = require("alpha.themes.dashboard")

  -- Load UI elements.
  local header = dashboard.section.header
  local buttons = dashboard.section.buttons
  local footer = dashboard.section.footer
  -- Header.
  header.val = minv.builtin.dashboard.header()
  header.opts.hl = "DashboardHeader"
  -- Buttons.
  buttons.val = {}
  for _, val in ipairs(minv.builtin.dashboard.buttons) do
    local butn = dashboard.button(table.unpack(val))
    butn.opts.hl = "DashboardCenter"
    butn.opts.hl_shortcut = "DashboardShortcut"
    table.insert(buttons.val, butn)
  end
  -- Footer.
  footer.val = minv.builtin.dashboard.footer()
  footer.opts.hl = "DashboardFooter"

  -- Setup alpha.
  require("alpha").setup(dashboard.config)
end

return M
