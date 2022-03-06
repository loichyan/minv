local M = {}

function M.preset()
  local utils = require("utils")

  ---@class MiNVPresetTrouble
  local preset = {
    enable = true,
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
    after = utils.callback.new(),
  }
  return preset
end

---@param preset MiNVPresetTrouble
---@param minv MiNV
function M.apply(preset, minv)
  if preset.enable then
    minv.builtin.lsp.on_attach:add(function(buf)
      preset.keymaps:apply({ buffer = buf })
    end)
  end
end

---@param preset MiNVPresetTrouble
function M.setup(preset)
  -- Setup trouble.
  require("trouble").setup(preset.setup)
end

return M
