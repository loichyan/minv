local M = {}

function M.preset()
  ---@class MiNVPresetAlpha
  local preset = {
    header = {
      "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
      "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
      "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
      "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
      "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
      "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
    },
    buttons = {
      { "f", "  Find File  ", ":Telescope find_files<CR>" },
      { "o", "  Recent File  ", ":Telescope oldfiles<CR>" },
      { "n", "  New File", ":ene<CR>" },
      { "w", "  Find Word  ", ":Telescope live_grep<CR>" },
      { "m", "  Bookmarks  ", ":Telescope marks<CR>" },
      { "h", "  Themes  ", ":Telescope colorscheme<CR>" },
      { "q", "  Quit", ":qa<CR>" },
    },
    footer = "Have fun with Neovim!",
  }
  return preset
end

---@param preset MiNVPresetAlpha
function M.setup(preset)
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")
  local utils = require("utils")

  -- Setup alpha.
  dashboard.section.header.val = preset.header
  dashboard.section.buttons.val = utils.list_map(preset.buttons, function(params)
    return dashboard.button(table.unpack(params))
  end)
  dashboard.section.footer.val = preset.footer
  alpha.setup(dashboard.config)
end

return M
