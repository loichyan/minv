local M = {}

local function _random_map()
  local RandomMap = {
    ---@type table<integer,any>
    _map = {},
  }

  ---@param val any
  ---@return integer
  function RandomMap:insert(val)
    -- Look for a new id.
    local id
    repeat
      id = math.random(10000, 99999)
    until self._map[id] == nil
    -- Insert the value.
    self._map[id] = val
    return id
  end

  ---@param key integer
  ---@return any
  function RandomMap:get(key)
    return self._map[key]
  end

  return RandomMap
end

local _registered_keys = _random_map()

---Register a `<Plug>` key to the global variable.
---@return string
function M.register_key()
  return string.format("<Plug>(MiNVRegisteredKey#%d)", _registered_keys:insert(true))
end

return M
