local M = {}

---@param init_list table[]|nil
---@return MiNV.PluginGroup
function M.new(init_list)
  ---@class MiNV.PluginGroup
  local PluginGroup = {
    ---@type table
    _spec = {},
    ---@type table<string,table>
    _plugins = {},
  }

  ---@param opt table
  ---@return MiNV.PluginGroup
  function PluginGroup:spec(opt)
    self._spec = vim.tbl_extend("force", self._spec, opt)
    return self
  end

  ---@param plug string
  ---@param opt table
  ---@return MiNV.PluginGroup
  function PluginGroup:spec_of(plug, opt)
    self._plugins[plug] = vim.tbl_extend("force", self._plugins[plug], opt)
    return self
  end

  ---@param list table[]
  ---@return MiNV.PluginGroup
  function PluginGroup:extend(list)
    for _, plug in ipairs(list) do
      self._plugins[plug[1]] = plug
    end
    return self
  end

  ---@param plug string
  ---@return MiNV.PluginGroup
  function PluginGroup:remove(plug)
    self._plugins[plug] = nil
    return self
  end

  ---@return table[]
  function PluginGroup:to_plugins()
    local plugins = {}
    for name, plug in pairs(self._plugins) do
      table.insert(plugins, vim.tbl_extend("force", self._spec, plug, { name }))
    end
    return plugins
  end

  return PluginGroup:extend(init_list or {})
end

return M
