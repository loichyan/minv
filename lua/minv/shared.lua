--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____presets = require("minv.presets")
local PRESETS = ____presets.PRESETS
local ____plugins = require("minv.plugins")
local PLUGINS = ____plugins.PLUGINS
local ____keybindings = require("minv.keybindings")
local KEYBINDINGS = ____keybindings.KEYBINDINGS
local ____config = require("minv.config")
local CONFIG = ____config.CONFIG
local ____autocmds = require("minv.autocmds")
local AUTOCMDS = ____autocmds.AUTOCMDS
local ____settings = require("minv.settings")
local SETTINGS = ____settings.SETTINGS
____exports.MINV = {
    config = CONFIG,
    plugins = PLUGINS,
    presets = PRESETS,
    keybindings = KEYBINDINGS,
    settings = SETTINGS,
    autocmds = AUTOCMDS
}
return ____exports
