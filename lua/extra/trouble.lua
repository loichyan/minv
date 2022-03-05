local M = {}

function M.preset()
  ---@class MiNVPresetTrouble
  local preset = {
    enable = true,
    setup = {
      indent_lines = false,
      auto_close = true,
    },
    keymaps = {
      implementation = "gI",
      references = "gr",
      document_diagnostics = "<Leader>le",
      workspace_diagnostics = "<Leader>lE",
    },
    after = nil,
  }
  return preset
end

---@param preset MiNVPresetTrouble
---@param minv MiNV
function M.apply(preset, minv)
  if preset.enable then
    minv.builtin.lsp.on_attach = function(buf)
      local keymaps = preset.keymaps
      require("utils").keymaps({
        buffer = buf,
        { keymaps.implementation, "<Cmd>Trouble lsp_implementations<CR>" },
        { keymaps.references, "<Cmd>Trouble lsp_references<CR>" },
        { keymaps.document_diagnostics, "<Cmd>Trouble document_diagnostics<CR>" },
        { keymaps.workspace_diagnostics, "<Cmd>Trouble workspace_diagnostics<CR>" },
      })
    end
  end
end

---@param preset MiNVPresetTrouble
function M.setup(preset)
  -- Setup trouble.
  require("trouble").setup(preset.setup)
end

return M
