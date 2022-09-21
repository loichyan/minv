--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
do
    local ____utils = require("spark/utils")
    local deep_merge = ____utils.deep_merge
    ____exports.deep_merge = deep_merge
end
function ____exports.merge(behavior, t1, ...)
    local rest = {...}
    local tbl1 = t1
    for _, tbl2 in ipairs(rest) do
        for k, v2 in pairs(tbl2) do
            local v1 = tbl1[k]
            if behavior == "force" then
                if v2 ~= nil then
                    tbl1[k] = v2
                end
            elseif v1 == nil then
                tbl1[k] = v2
            end
        end
    end
    return tbl1
end
function ____exports.plug_key(name)
    return string.format("<Plug>(minv.%s)", name)
end
function ____exports.mkHint()
    return function(u)
        return u
    end
end
function ____exports.autocmd(event, cmd, opts)
    local command
    local callback
    if type(cmd) == "string" then
        command = cmd
    elseif type(cmd) == "function" then
        callback = cmd
    end
    local options = vim.tbl_extend("keep", {command = command, callback = callback}, opts or ({}))
    vim.api.nvim_create_autocmd(event, options)
end
local DEFAULT_VIM_OPTS = {
    noremap = true,
    nowait = -1,
    silent = true,
    script = -1,
    expr = -1,
    unique = -1,
    desc = -1
}
local DEFAULT_MODE = "n"
function ____exports.set_keymap(lhs, cmd, opts)
    local rhs
    local callback
    if type(cmd) == "string" then
        rhs = cmd
    else
        rhs = ""
        callback = cmd
    end
    local vopts = {callback = callback}
    for k, v in pairs(DEFAULT_VIM_OPTS) do
        local v2 = opts[k]
        local ____k_1 = k
        local ____temp_0
        if v2 == nil and v ~= -1 then
            ____temp_0 = v
        else
            ____temp_0 = v2
        end
        vopts[____k_1] = ____temp_0
    end
    local mode = opts.mode or DEFAULT_MODE
    local buffer = opts.buffer
    if buffer ~= nil then
        vim.api.nvim_buf_set_keymap(
            buffer,
            mode,
            lhs,
            rhs,
            vopts
        )
    else
        vim.api.nvim_set_keymap(mode, lhs, rhs, vopts)
    end
end
local function apply_act(tbl, key, act)
    if act["$set"] ~= nil then
        tbl[key] = act["$set"]
        return true
    elseif act["$merge"] ~= nil then
        ____exports.merge("force", tbl[key], act["$merge"])
        return true
    elseif act["$concat"] ~= nil then
        vim.list_extend(tbl[key], act["$concat"])
        return true
    elseif act["$insert"] ~= nil then
        local pos, val = unpack(act["$insert"])
        table.insert(tbl[key], pos, val)
        return true
    elseif act["$batch"] ~= nil then
        for _, a in ipairs(act["$batch"]) do
            apply_act(tbl, key, a)
        end
        return true
    else
        return false
    end
end
function ____exports.apply_updater(tbl, updater)
    for key, act in pairs(updater) do
        if not apply_act(tbl, key, act) then
            local oldval = tbl[key]
            if type(oldval) ~= "table" then
                local ____tbl_2 = tbl
                local ____key_3 = key
                oldval = {}
                ____tbl_2[____key_3] = oldval
            end
            ____exports.apply_updater(oldval, act)
        end
    end
end
return ____exports
