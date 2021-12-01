-- Load presets.
--
-- Note: we use a global variable here due to this
-- [limition](https://github.com/wbthomason/packer.nvim#compiling-lazy-loaders).
_MINV = require("preset")

-- Load custom settings.
local ok, custom = pcall(require, "custom")
if ok then
  custom.setup(_MINV)
end

-- Setup.
require("core").setup(_MINV)
