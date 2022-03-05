local M = {}

function M.new()
  ---Callbacks.
  ---@class MiNVCallback
  local Callback = {
    ---@type function[]
    _callbacks = {},
  }

  ---@param f function
  function Callback:add(f)
    table.insert(self._callbacks, f)
  end

  function Callback:apply(...)
    for _, f in ipairs(self._callbacks) do
      f(...)
    end
  end

  return Callback
end

return M
