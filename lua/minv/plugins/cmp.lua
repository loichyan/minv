--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____keybindings = require("minv.keybindings")
local map_bindings = ____keybindings.map_bindings
local ____presets = require("minv.presets")
local PRESETS = ____presets.PRESETS
local ____utils = require("minv.utils")
local deep_merge = ____utils.deep_merge
function ____exports.setup()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local cmp_mapping = cmp.mapping
    local function locally_jumpable(dire)
        return luasnip.jumpable(dire) and luasnip.in_snippet()
    end
    local mapping = map_bindings({
        ["cmp.close"] = cmp_mapping.close(),
        ["cmp.complete"] = cmp_mapping.complete(),
        ["cmp.confirm"] = cmp_mapping.confirm({select = true}),
        ["cmp.scroll_down"] = cmp_mapping.scroll_docs(4),
        ["cmp.scroll_up"] = cmp_mapping.scroll_docs(-4),
        ["cmp.select_next"] = cmp_mapping(function(____, fb)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif locally_jumpable(1) then
                luasnip.jump(1)
            else
                fb()
            end
        end),
        ["cmp.select_prev"] = cmp_mapping(function(____, fb)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fb()
            end
        end)
    })
    local bordered = cmp.config.window.bordered()
    local cmp_opts = deep_merge("keep", {mapping = mapping}, PRESETS.cmp, {window = {completion = bordered, documentation = bordered}, confirmation = {default_behavior = cmp.ConfirmBehavior.Replace}})
    luasnip.config.setup(PRESETS.luasnip)
    cmp.setup(cmp_opts)
    require("luasnip.loaders.from_vscode").lazy_load()
end
return ____exports
