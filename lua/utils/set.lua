local M = {}

---@param init_list any[]|nil
function M.new(init_list)
  ---Ordered set.
  ---@class MiNVSet
  local Set = {
    ---@type any[]
    _elements = {},
    ---@type table<any, boolean>
    _existent = {},
  }

  function Set:add(key)
    if self:has(key) then
      return
    end
    self._existent[key] = true
    table.insert(self._elements, key)
  end

  function Set:has(key)
    return self._existent[key] == true
  end

  function Set:remove(key)
    self._elements[key] = false
  end

  function Set:update()
    local _elements = {}
    local _existent = {}
    for _, key in ipairs(self._elements) do
      if self:has(key) then
        table.insert(_elements, key)
        _existent[key] = true
      end
    end
    self._existent = _existent
    self._elements = _elements
  end

  function Set:extend(list)
    for _, val in ipairs(list) do
      self:add(val)
    end
  end

  function Set:to_list()
    self:update()
    local list = {}
    for _, key in ipairs(self._elements) do
      table.insert(list, key)
    end
    return list
  end

  if init_list ~= nil then
    Set:extend(init_list)
  end

  return Set
end

return M
