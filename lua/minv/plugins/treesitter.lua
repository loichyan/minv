--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____keybindings = require("minv.keybindings")
local apply_mappings = ____keybindings.apply_mappings
local mkPlugKeySrc = ____keybindings.mkPlugKeySrc
local apply_extra = ____keybindings.apply_extra
local ____presets = require("minv.presets")
local PRESETS = ____presets.PRESETS
local ____utils = require("minv.utils")
local deep_merge = ____utils.deep_merge
local MAPPINGS = {
    toggle = mkPlugKeySrc({["comment.toggle_line"] = "Toggle line comments", ["comment.toggle_block"] = "Toggle block comments"}),
    oplead = mkPlugKeySrc({["comment.oplead_line"] = "Toggle line comments", ["comment.oplead_block"] = "Toggle block comments"}),
    insert = mkPlugKeySrc({["comment.insert_above"] = "Insert comments above", ["comment.insert_below"] = "Insert comments below", ["comment.insert_eol"] = "Insert comments eol"})
}
local function mkMappingsForComment(target)
    local trim = #"comment._" + #target + 1
    local mappings = {}
    for name, src in pairs(MAPPINGS[target]) do
        mappings[string.sub(name, trim)] = src.cmd
    end
    return mappings
end
local COMMENT_DEFAULT = {
    toggler = mkMappingsForComment("toggle"),
    opleader = mkMappingsForComment("oplead"),
    extra = mkMappingsForComment("insert"),
    mappings = {basic = true, extra = true, extended = false}
}
function ____exports.setup_treesitter()
    require("nvim-treesitter.configs").setup(PRESETS.treesitter)
end
function ____exports.setup_comment()
    local pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
    require("Comment").setup(deep_merge("keep", {pre_hook = pre_hook}, COMMENT_DEFAULT, PRESETS.comment))
    apply_mappings(MAPPINGS.toggle, {noremap = false})
    apply_mappings(MAPPINGS.oplead, {mode = "x", noremap = false})
    apply_mappings(MAPPINGS.oplead, {noremap = false})
    apply_mappings(MAPPINGS.insert, {noremap = false})
    apply_extra("comment.extra", {mode = "n"})
end
function ____exports.setup_surround()
    require("nvim-surround").setup(PRESETS.surround)
end
return ____exports
