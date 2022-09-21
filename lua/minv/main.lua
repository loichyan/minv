--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____autocmds = require("minv.autocmds")
local setup_autocmds = ____autocmds.setup_autocmds
local ____keybindings = require("minv.keybindings")
local setup_keybindings = ____keybindings.setup_keybindings
local ____plugins = require("minv.plugins")
local collect_plugins = ____plugins.collect_plugins
local ____settings = require("minv.settings")
local setup_settings = ____settings.setup_settings
local ____shared = require("minv.shared")
local ALL_PLUGINS = ____shared.ALL_PLUGINS
local MINV = ____shared.MINV
local ____utils = require("minv.utils")
local deep_merge = ____utils.deep_merge
function ____exports.setup_spark()
    return require("spark")
end
local function load_plugins()
    local plugs = collect_plugins()
    local opts = {[1] = function(use)
        for _, plug in ipairs(plugs) do
            use(plug)
        end
    end}
    local spark = ____exports.setup_spark()
    spark.setup(deep_merge("keep", opts, MINV.presets.spark))
    for _, plug in ipairs(spark.plugins()) do
        ALL_PLUGINS[plug[1]] = plug
    end
    spark.load()
    spark.post_load()
end
function ____exports.setup(custom)
    custom(MINV)
    setup_settings()
    load_plugins()
    setup_keybindings()
    setup_autocmds()
end
return ____exports
