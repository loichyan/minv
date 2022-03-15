local M = {}

function M.preset()
  return {
    header = function()
      return {
        "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
        "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
        "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
        "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
        "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
        "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
      }
    end,
    buttons = {
      { "n", "  New Files", "<Cmd>ene<CR>" },
      { "o", "  Recent Files", "<Cmd>Telescope oldfiles<CR>" },
      { "f", "  Find Files", "<Cmd>Telescope find_files<CR>" },
      { "w", "  Find Words", "<Cmd>Telescope live_grep<CR>" },
      { "m", "  Find Bookmarks", "<Cmd>Telescope marks<CR>" },
      { "h", "  Find Themes", "<Cmd>Telescope colorscheme<CR>" },
      { "q", "  Quit", "<Cmd>qa<CR>" },
    },
    footer = function()
      return string.format("Neovim loaded %s plugins  ", vim.tbl_count(packer_plugins))
    end,
  }
end

---@param minv MiNV
function M.setup(minv)
  local dashboard = require("alpha.themes.dashboard")

  -- Load UI elements.
  local header = dashboard.section.header
  local buttons = dashboard.section.buttons
  local footer = dashboard.section.footer
  -- Header
  header.val = minv.builtin.dashboard.header()
  header.opts.hl = "DashboardHeader"
  -- Buttons
  buttons.val = {}
  for _, val in ipairs(minv.builtin.dashboard.buttons) do
    local butn = dashboard.button(unpack(val))
    butn.opts.hl = "DashboardCenter"
    butn.opts.hl_shortcut = "DashboardShortcut"
    table.insert(buttons.val, butn)
  end
  -- Footer
  footer.val = minv.builtin.dashboard.footer()
  footer.opts.hl = "DashboardFooter"

  -- Setup alpha.
  require("alpha").setup(dashboard.config)
end

return M
