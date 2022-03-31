local M = {}

function M.preset()
  return {
    enable = true,
    operators = { ["gc"] = "Toggle line comments", ["gb"] = "Toggle block comments" },
    triggers = "auto",
    ignore_missing = false,
    groups = {
      ["<Leader>l"] = "Lsp",
      ["<Leader>f"] = "Search",
      ["<Leader>g"] = "Git",
    },
  }
end

---@param minv MiNV
function M.setup(minv)
  local ok, which_key = pcall(require, "which-key")
  if not ok then
    return
  end

  local preset = minv.builtin.which_key
  which_key.setup({
    operators = preset.operators,
    triggers = preset.triggers,
    ignore_missing = preset.ignore_missing,
  })
  local groups = {}
  for key, name in pairs(preset.groups) do
    groups[key] = { name = name }
  end
  which_key.register(groups)

  -- Use which-key to handle bindings.
  local kb = require("utils.keybinding")
  ---@param mode string
  ---@param buffer? integer
  ---@param bindings table<string,any[]>
  ---@param options table<string,boolean>
  kb.handler = function(mode, buffer, bindings, options)
    for lhs, val in pairs(bindings) do
      local rhs, name = unpack(val)
      local _, _, opts = kb.parse_options(val)
      which_key.register(
        { [lhs] = { rhs, name } },
        vim.tbl_extend("force", options, opts, {
          prefix = "",
          mode = mode,
          buffer = buffer,
        })
      )
    end
  end
end

return M
