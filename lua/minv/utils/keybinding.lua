local M = {}

---@param options table<string,any>
---@return string?,integer?,table<string,boolean>
function M.parse_options(options)
  local mode = options.mode
  local buffer = options.buffer
  local opts = {
    noremap = options.noremap,
    silent = options.silent,
    nowait = options.nowait,
    script = options.script,
    expr = options.expr,
    unique = options.unique,
  }
  return mode, buffer, opts
end

---@param mode string
---@param buffer? integer
---@param bindings table<string,any[]>
---@param options table<string,boolean>
function M.handler(mode, buffer, bindings, options)
  -- Determine bindings handler.
  local map = vim.api.nvim_set_keymap
  if buffer ~= nil then
    map = function(...)
      vim.api.nvim_buf_set_keymap(buffer, ...)
    end
  end

  -- Apply bindings.
  for lhs, val in pairs(bindings) do
    local rhs, desc = unpack(val)
    local _, _, opts = M.parse_options(val)
    opts.desc = desc
    if type(rhs) == "function" then
      opts.callback = rhs
      rhs = ""
    end
    map(mode, lhs, rhs, vim.tbl_extend("force", options, opts))
  end
end

---@param init_bindings?  table<string,any>
---@return MiNV.Keybinding
function M.new(init_bindings)
  ---@class MiNV.Keybinding
  local Keybinding = {
    ---@type table<string,any[]|string>
    _bindings = {},
    ---@type table<string,string>
    _unbinded = {},
  }

  ---@param bindings table<string,any>
  ---@param prefix? string
  ---@return MiNV.Keybinding
  function Keybinding:extend(bindings, prefix)
    prefix = prefix or ""
    for key, binding in pairs(bindings) do
      if binding == "nop" then
        -- Allow using "nop" to remove a binding.
        self._unbinded[prefix .. key] = nil
      elseif type(binding) == "string" then
        -- Bind to a source.
        self._unbinded[prefix .. key] = binding
      elseif type(binding) == "table" then
        if #binding > 0 then
          -- Bind to a command.
          self._bindings[prefix .. key] = binding
        else
          -- Nested binding.
          self:extend(binding, prefix .. key)
        end
      end
    end
    return self
  end

  ---@generic T
  ---@param map table<string,T>
  ---@return table<string,T>,table<string,any>
  function Keybinding:map(map)
    local mapped = {}
    for key, src in pairs(self._unbinded) do
      local binding = map[src]
      mapped[key] = binding
    end
    return mapped, self._bindings
  end

  ---@param sources? table<string,any[]>
  ---@param options? table<string,any>
  function Keybinding:apply(sources, options)
    local mode, buffer, opts = M.parse_options(options or {})
    -- Default options.
    mode = mode or "n"
    opts.noremap = opts.noremap ~= false or false
    opts.silent = opts.silent ~= false or false

    local mapped, bindings = self:map(sources or {})
    M.handler(mode, buffer, mapped, opts)
    M.handler(mode, buffer, bindings, opts)
  end

  return Keybinding:extend(init_bindings or {})
end

return M
