--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____presets = require("minv.presets")
local PRESETS = ____presets.PRESETS
local update_preset = ____presets.update_preset
local ____plugins = require("minv.plugins")
local PLUGINS = ____plugins.PLUGINS
local extend_plugins = ____plugins.extend_plugins
local ____keybindings = require("minv.keybindings")
local KEYBINDINGS = ____keybindings.KEYBINDINGS
local update_keybindings = ____keybindings.update_keybindings
local ____config = require("minv.config")
local CONFIG = ____config.CONFIG
local ____autocmds = require("minv.autocmds")
local AUTOCMDS = ____autocmds.AUTOCMDS
local ____settings = require("minv.settings")
local SETTINGS = ____settings.SETTINGS
local ____utils = require("minv.utils")
local autocmd = ____utils.autocmd
local set_keymap = ____utils.set_keymap
____exports.ALL_PLUGINS = {}
local function forward_func(f)
    return function(self, ...)
        return f(...)
    end
end
____exports.MINV = {
    config = CONFIG,
    plugins = PLUGINS,
    presets = PRESETS,
    keybindings = KEYBINDINGS,
    settings = SETTINGS,
    autocmds = AUTOCMDS,
    get_plugin = function(self, name)
        return ____exports.ALL_PLUGINS[name]
    end,
    set_keymap = forward_func(set_keymap),
    set_autocmd = forward_func(autocmd),
    update_plugins = forward_func(extend_plugins),
    update_keybindings = forward_func(update_keybindings),
    update_preset = forward_func(update_preset)
}
return ____exports
