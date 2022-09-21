--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____utils = require("minv.utils")
local mkHint = ____utils.mkHint
local plug_key = ____utils.plug_key
____exports.KEYBINDINGS = mkHint()({
    ["normal.nohlsearch"] = {"<Esc>"},
    ["normal.save"] = {"<C-s>"},
    ["insert.escape"] = {"jk", "jj"},
    ["explorer.toggle"] = {"<C-n>"},
    ["explorer.focus"] = {"<C-b>"},
    ["buffer.close"] = {"<Leader>x"},
    ["buffer.goto_next"] = {"<S-l>"},
    ["buffer.goto_prev"] = {"<S-h>"},
    ["telescope.buffers"] = {"<Leader>fb"},
    ["telescope.document_symbols"] = {"<Leader>fs"},
    ["telescope.files"] = {"<Leader>fF"},
    ["telescope.git_commits"] = {"<Leader>fg"},
    ["telescope.grep"] = {"<Leader>ff"},
    ["telescope.marks"] = {"<Leader>fm"},
    ["telescope.recent_files"] = {"<Leader>fo"},
    ["telescope.registers"] = {"<Leader>fr"},
    ["telescope.workspace_symbols"] = {"<Leader>fS"},
    ["git.blame_line"] = {"<Leader>gb"},
    ["git.goto_next_hunk"] = {"]g"},
    ["git.goto_prev_hunk"] = {"[g"},
    ["git.preview_hunk"] = {"<Leader>gp"},
    ["git.reset_buffer"] = {"<Leader>gR"},
    ["git.reset_line"] = {"<Leader>gr"},
    ["git.stage_buffer"] = {"<Leader>gS"},
    ["git.state_hunk"] = {"<Leader>gs"},
    ["git.undo_stage_hunk"] = {"<Leader>gu"},
    ["comment.insert_above"] = {"gcO"},
    ["comment.insert_below"] = {"gco"},
    ["comment.insert_eol"] = {"gcA"},
    ["comment.oplead_block"] = {"gb"},
    ["comment.oplead_line"] = {"gc"},
    ["comment.toggle_block"] = {"gbc"},
    ["comment.toggle_line"] = {"gcc"},
    ["terminal.toggle"] = {"<C-t>"},
    ["lsp.formatting"] = {"<Leader>lf"},
    ["lsp.goto_declaration"] = {"gD"},
    ["lsp.goto_definition"] = {"gd"},
    ["lsp.goto_next_diagnostic"] = {"]d"},
    ["lsp.goto_next_error"] = {"]e"},
    ["lsp.goto_prev_diagnostic"] = {"[d"},
    ["lsp.goto_prev_error"] = {"[e"},
    ["lsp.hover"] = {"K"},
    ["lsp.rename"] = {"<Leader>lr"},
    ["lsp.show_code_action"] = {"<Leader>la"},
    ["lsp.show_diagnostic"] = {"ge"},
    ["lsp.show_document_diagnostics"] = {"<Leader>le"},
    ["lsp.show_implementation"] = {"gI"},
    ["lsp.show_references"] = {"gr"},
    ["lsp.show_signature_help"] = {"gk"},
    ["lsp.show_workspace_diagnostics"] = {"<Leader>lE"},
    ["cmp.close"] = {"<C-e>"},
    ["cmp.complete"] = {"<C-Space>"},
    ["cmp.confirm"] = {"<CR>"},
    ["cmp.scroll_down"] = {"<C-d>"},
    ["cmp.scroll_up"] = {"<C-u>"},
    ["cmp.select_next"] = {"<Tab>"},
    ["cmp.select_prev"] = {"<S-Tab>"}
})
local DEFAULT_OPTS = {
    noremap = true,
    nowait = false,
    silent = true,
    script = false,
    expr = false,
    unique = false
}
local function mkOptions(self, opts)
    local newOpts = {}
    for k, v in pairs(DEFAULT_OPTS) do
        local v2 = opts[k]
        local ____k_1 = k
        local ____temp_0
        if v2 ~= nil then
            ____temp_0 = v2
        else
            ____temp_0 = v
        end
        newOpts[____k_1] = ____temp_0
    end
    return newOpts
end
local function binding_handler(mode, buffer, lhs, cmd, desc, options)
    local callback
    local rhs = ""
    if type(cmd) == "function" then
        callback = cmd
    else
        rhs = cmd
    end
    local opts = vim.tbl_extend("keep", {desc = desc, callback = callback}, options)
    if buffer == nil then
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    else
        vim.api.nvim_buf_set_keymap(
            buffer,
            mode,
            lhs,
            rhs,
            opts
        )
    end
end
function ____exports.set_handler(new_handler)
    binding_handler = new_handler
end
function ____exports.map_bindings(mappings)
    local mapped = {}
    for name, val in pairs(mappings) do
        for _, lhs in ipairs(____exports.KEYBINDINGS[name]) do
            mapped[lhs] = val
        end
    end
    return mapped
end
function ____exports.apply_mappings(mappings, gOpts)
    for name, source in pairs(mappings) do
        local src = vim.tbl_extend("force", {mode = "n"}, source, gOpts or ({}))
        local opts = mkOptions(nil, src)
        local mode = src.mode
        local buffer = src.buffer
        local cmd = src.cmd
        local desc = src.desc
        for _, lhs in ipairs(____exports.KEYBINDINGS[name]) do
            binding_handler(
                mode,
                buffer,
                lhs,
                cmd,
                desc,
                opts
            )
        end
    end
end
function ____exports.mkPlugKeySrc(descs)
    local keys = {}
    for name, desc in pairs(descs) do
        keys[name] = {
            cmd = plug_key(name),
            desc = desc
        }
    end
    return keys
end
____exports.COMMON_MAPPINGS = mkHint()({["insert.escape"] = {cmd = "<Esc>", desc = "Escape", mode = "i"}, ["normal.nohlsearch"] = {cmd = "<Cmd>nohlsearch<CR>", desc = "Stop hlsearch"}, ["normal.save"] = {cmd = "<Cmd>write<CR>", desc = "Save changes"}})
function ____exports.setup()
    ____exports.apply_mappings(____exports.COMMON_MAPPINGS)
end
return ____exports
