local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVPresetTrouble
  local preset = {
    enable = true,
    after = utils.callback.new(),
    setup = {
      indent_lines = false,
      auto_close = true,
    },
    keymaps = utils.keymap.new({
      ["g"] = {
        ["I"] = { "<Cmd>Trouble lsp_implementations<CR>", "Show implementations" },
        ["r"] = { "<Cmd>Trouble lsp_references<CR>", "Show references" },
      },
      ["<Leader>l"] = {
        ["e"] = { "<Cmd>Trouble document_diagnostics<CR>", "Show document diagnostics" },
        ["E"] = { "<Cmd>Trouble workspace_diagnostics<CR>", "Show workspace diagnostics" },
      },
    }),
  }
  return preset
end

---@param preset MiNVPresetTrouble
---@param minv MiNV
function M.apply(preset, minv)
  if preset.enable then
    minv.builtin.lsp.keymaps:extend(preset.keymaps:to_mappings())
  end
end

---@param preset MiNVPresetTrouble
function M.setup(preset)
  -- Setup trouble.
  require("trouble").setup(preset.setup)
end

return M
