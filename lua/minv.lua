--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local function load_plugins()
    local plugins = require("minv.plugins")
    local presets = require("minv.presets").PRESETS.spark
    local utils = require("minv.utils")
    local spark = require("minv.spark").setup()
    local plugs = plugins.collect_plugins()
    local opts = {[1] = function(use)
        for _, plug in ipairs(plugs) do
            use(plug)
        end
    end}
    spark.setup(utils.deep_merge("keep", opts, presets))
    spark.load()
    spark.post_load()
end
function ____exports.setup(custom)
    pcall(require, "impatient")
    custom(require("minv.shared").MINV)
    require("minv.settings").setup()
    load_plugins()
    require("minv.keybindings").setup()
    require("minv.autocmds").setup()
end
return ____exports
