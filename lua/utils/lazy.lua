local M = {}

function M.new(init_func)
  ---@class MiNVPreset
  local Preset = {
    ---@type fun():any
    _init = init_func,
    ---@type function[]
    _commits = {},
  }

  --_@param func func(any)
  function Preset:commit(func)
    table.insert(self._commits, func)
  end

  ---@return any
  function Preset:apply()
    local val = self._init()
    for _, func in ipairs(self._commits) do
      func(val)
    end
    return val
  end

  return Preset
end

return M
