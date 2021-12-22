-- Load presets.
_MINV = require("preset").new()

-- Load custom settings.
local ok, custom = pcall(require, "custom")
if ok then
  custom.setup(_MINV)
end

-- Setup.
require("core").setup(_MINV)
