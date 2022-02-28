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
  local components = M.components()
  ---@class MiNVPresetLualine
  local preset = {
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
          components.lsp,
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
    extensions = {
      ["nvim-tree"] = true,
      ["toggleterm"] = true,
    },
  }
  return preset
end

---@param preset MiNVPresetLualine
function M.setup(preset)
  local lualine = require("lualine")
  local utils = require("utils")

  -- Setup lualine.
  lualine.setup(utils.tbl_merge(preset.setup, {
    extensions = utils.set_to_list(preset.extensions),
  }))
end

return M
