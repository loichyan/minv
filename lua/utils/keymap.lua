local others = require("utils.others")
local M = {}

---@param mappings table<string,string|function>
---@param options table|nil
function M.set(mappings, options)
  -- Default optiosn.
  options = vim.tbl_extend("force", {
    mode = "n",
    noremap = true,
    silent = true,
  }, options or {})

  -- Remove non map option keys.
  local mode = options.mode
  options.mode = nil
  local buffer = options.buffer
  options.buffer = nil

  -- Determine mappings handler.
  local map = vim.api.nvim_set_keymap
  if buffer ~= nil then
    map = function(...)
      vim.api.nvim_buf_set_keymap(buffer, ...)
    end
  end

  -- Apply mappings.
  for lhs, rhs in pairs(mappings) do
    if type(rhs) == "function" then
      rhs = string.format("<Cmd>%s<CR>", others.cmd(rhs))
    end
    map(mode, lhs, rhs, options)
  end
end

function M.new(init_mappings)
  ---@class MiNVKeymap
  local Keymap = {
    ---@type table<string,table<string,string|table>>
    _prefixed = {},
    ---@type table<string,string|function>
    _mappings = {},
  }

  ---@param mappings table<string,string|function|table<string,string|table>>
  function Keymap:extend(mappings)
    for key, val in pairs(mappings) do
      if type(val) == "table" then
        self._prefixed[key] = vim.tbl_extend("force", self._prefixed[key] or {}, val)
      else
        self._mappings[key] = val
      end
    end
  end

  ---@param key string
  function Keymap:get(key)
    return self._prefixed[key] or self._mappings[key]
  end

  ---@param options table|nil
  function Keymap:apply(options)
    options = options or {}

    -- Apply mappings without prefix.
    M.set(self._mappings, options)

    -- Handle mappings if which-key not enabled.
    local wk_register = function(prefix, mappings, opts)
      local mappings2 = {}
      for lhs, rhs in pairs(mappings) do
        if type(rhs) == "table" then
          rhs = rhs[1]
        end
        mappings2[prefix .. lhs] = rhs
      end
      M.set(mappings2, opts)
    end

    -- Use which-key to handle mappings.
    local ok, wk = pcall(require, "which-key")
    if ok then
      wk_register = function(prefix, mappings, opts)
        wk.register(mappings, vim.tbl_extend("force", opts, { prefix = prefix }))
      end
    end

    -- Apply prefixed mappings.
    for prefix, mappings in pairs(self._prefixed) do
      wk_register(prefix, mappings, options)
    end
  end

  function Keymap:to_mappings()
    return vim.tbl_extend("force", self._prefixed, self._prefixed)
  end

  if init_mappings ~= nil then
    Keymap:extend(init_mappings)
  end

  return Keymap
end

return M
