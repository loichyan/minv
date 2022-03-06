local M = {}

function M.components()
  return {
    mode = {
      function()
        return " "
      end,
      padding = { left = 1, right = 1 },
    },
    branch = { "branch" },
    filename = { "filename" },
    diff = { "diff" },
    diagnostics = { "diagnostics", sources = { "nvim_diagnostic" } },
    encoding = { "encoding", fmt = string.upper },
    fileformat = { "fileformat" },
    filetype = { "filetype", fmt = string.upper },
    progress = { "progress" },
  }
end

function M.preset()
  local utils = require("utils")
  local components = M.components()

  ---@class MiNVPresetLualine
  local preset = {
    after = utils.callback.new(),
    setup = {
      options = {
        theme = "auto",
      },
      sections = {
        lualine_a = {
          components.mode,
        },
        lualine_b = {
          components.branch,
          components.filename,
        },
        lualine_c = {
          components.diff,
        },
        lualine_x = {
          components.diagnostics,
        },
        lualine_y = {
          components.encoding,
          components.fileformat,
          components.filetype,
        },
        lualine_z = {
          components.progress,
        },
      },
    },
    extensions = utils.set.new({
      "nvim-tree",
      "toggleterm",
    }),
  }
  return preset
end

---@param preset MiNVPresetLualine
function M.setup(preset)
  local utils = require("utils")

  -- Setup lualine.
  require("lualine").setup(utils.tbl_merge(preset.setup, {
    extensions = preset.extensions:to_list(),
  }))
end

return M
