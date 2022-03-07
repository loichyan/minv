local register = require("utils.register")
local M = {}

---@param options table<string,any>
---@return string?,number?,table<string,boolean>
local function parse_options(options)
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

local function get_binding_handler()
  ---@param mode string
  ---@param buffer? integer
  ---@param bindings table<string,any[]>
  ---@param options table<string,boolean>
  local handler = function(mode, buffer, bindings, options)
    -- Determine bindings handler.
    local map = vim.api.nvim_set_keymap
    if buffer ~= nil then
      map = function(...)
        vim.api.nvim_buf_set_keymap(buffer, ...)
      end
    end

    -- Apply bindings.
    for lhs, val in pairs(bindings) do
      local rhs, _ = table.unpack(val)
      local _, _, opts = parse_options(val)
      if type(rhs) == "function" then
        rhs = string.format("<Cmd>%s<CR>", register.cmd(rhs))
      end
      map(mode, lhs, rhs, vim.tbl_extend("force", options, opts))
    end
  end

  -- Use which-key to handle bindings.
  local ok, wk = pcall(require, "which-key")
  if ok then
    ---@param mode string
    ---@param buffer? integer
    ---@param bindings table<string,any[]>
    ---@param options table<string,boolean>
    handler = function(mode, buffer, bindings, options)
      for lhs, val in pairs(bindings) do
        local rhs, name = table.unpack(val)
        local _, _, opts = parse_options(val)
        wk.register(
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

  return handler
end

local binding_handler = get_binding_handler()

---@param init_bindings?  table<string,string|any[]|table<string,string|any[]>>
function M.new(init_bindings)
  ---@class MiNVKeybinding
  local Keybinding = {
    ---@type table<string,any[]|string>
    _bindings = {},
  }

  ---@key string
  ---@return string
  function Keybinding:get(key)
    return self._bindings[key]
  end

  ---@param key string
  ---@param binding string|any[]|table<string,string|any[]>
  function Keybinding:insert(key, binding)
    if type(binding) == "table" then
      if #binding == 2 then
        -- Bind to a command.
        self._bindings[key] = binding
      elseif #binding == 0 then
        -- Nested bindings.
        for key2, val in pairs(binding) do
          if type(val) == "string" or (type(val) == "table" and #val == 2) then
            self._bindings[key .. key2] = val
          end
        end
      end
    elseif type(binding) == "string" then
      -- Bind to a source.
      self._bindings[key] = binding
    end
  end

  ---@param bindings table<string,string|any[]|table<string,string|any[]>>
  function Keybinding:extend(bindings)
    for key, val in pairs(bindings) do
      self:insert(key, val)
    end
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
    local mode, buffer, opts = parse_options(options or {})
    -- Default options.
    mode = mode or "n"
    opts.noremap = opts.noremap ~= false or false
    opts.silent = opts.silent ~= false or false

    local bindings, unmapped = self:map(sources or {})
    -- Apply unsourced bindings.
    if unsourced then
      binding_handler(mode, buffer, unmapped, opts)
    end
    binding_handler(mode, buffer, bindings, opts)
  end

  if init_bindings ~= nil then
    Keybinding:extend(init_bindings)
  end

  return Keybinding
end

return M
