--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____keybindings = require("minv.keybindings")
local apply_mappings = ____keybindings.apply_mappings
local mkPlugKeySrc = ____keybindings.mkPlugKeySrc
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
local function pre_hook(ctx)
    local comment_utils = require("Comment.utils")
    local cmstring_utils = require("ts_context_commentstring.utils")
    local key = "__default"
    if ctx.ctype ~= comment_utils.ctype.line then
        key = "__multiline"
    end
    local location
    if ctx.ctype == comment_utils.ctype.block then
        location = cmstring_utils.get_cursor_location()
    elseif ctx.cmotion == comment_utils.cmotion.v or ctx.motion == comment_utils.cmotion.V then
        location = cmstring_utils.get_visual_start_location()
    end
    return require("ts_context_commentstring.internal").calculate_commentstring({key = key, location = location})
end
local COMMENT_DEFAULT = {
    pre_hook = pre_hook,
    toggler = mkMappingsForComment("toggle"),
    opleader = mkMappingsForComment("oplead"),
    extra = mkMappingsForComment("insert"),
    mappings = {basic = true, extra = true, extended = false}
}
function ____exports.setup_treesitter()
    require("nvim-treesitter.configs").setup(PRESETS.treesitter)
end
function ____exports.setup_comment()
    require("Comment").setup(deep_merge("keep", {}, COMMENT_DEFAULT, PRESETS.comment))
    apply_mappings(MAPPINGS.toggle, {noremap = false})
    apply_mappings(MAPPINGS.oplead, {mode = "x", noremap = false})
    apply_mappings(MAPPINGS.insert, {noremap = false})
end
function ____exports.setup_surround()
    require("nvim-surround").setup(PRESETS.surround)
end
return ____exports
