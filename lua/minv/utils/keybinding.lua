local M = {}

---@param options table<string,any>
---@return string?,number?,table<string,boolean>
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

---@param init_bindings?  table<string,string|any[]|table<string,string|any[]>>
---@return MiNV.Keybinding
function M.new(init_bindings)
  ---@class MiNV.Keybinding
  local Keybinding = {
    ---@type table<string,any[]|string>
    _bindings = {},
  }

  ---@key string
  ---@return string
  function Keybinding:get(key)
    return self._bindings[key]
  end

  ---@param bindings table<string,string|any[]|table<string,string|any[]>>
  ---@return MiNV.Keybinding
  function Keybinding:extend(bindings)
    for key, binding in pairs(bindings) do
      if type(binding) == "table" then
        if #binding == 2 then
          -- Bind to a command.
          self._bindings[key] = binding
        elseif #binding == 0 then
          -- Nested bindings.
          for key2, val in pairs(binding) do
            -- allow using "nop" to ignore a binding
            if
              (type(val) == "string" and val ~= "nop")
              or (type(val) == "table" and #val == 2)
            then
              self._bindings[key .. key2] = val
            end
          end
        end
      elseif type(binding) == "string" then
        -- Bind to a source.
        self._bindings[key] = binding
      end
    end
    return self
  end

  ---@generic T
  ---@param map table<string,T>
  ---@return table<string,T>,table<string,any[]>
  function Keybinding:map(map)
    local bindings = {}
    local unmapped = {}
    for key, val in pairs(self._bindings) do
      if type(val) == "string" then
        bindings[key] = map[val]
      else
        unmapped[key] = val
      end
    end
    return bindings, unmapped
  end

  ---@param unsourced boolean
  ---@param sources? table<string,any[]>
  ---@param options? table<string,any>
  function Keybinding:apply(unsourced, sources, options)
    local mode, buffer, opts = M.parse_options(options or {})
    -- Default options.
    mode = mode or "n"
    opts.noremap = opts.noremap ~= false or false
    opts.silent = opts.silent ~= false or false

    local bindings, unmapped = self:map(sources or {})
    -- Apply unsourced bindings.
    if unsourced then
      M.handler(mode, buffer, unmapped, opts)
    end
    M.handler(mode, buffer, bindings, opts)
  end

  return Keybinding:extend(init_bindings or {})
end

return M
