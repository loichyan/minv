--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____utils = require("minv.utils")
local apply_updater = ____utils.apply_updater
local mkHint = ____utils.mkHint
local plug_key = ____utils.plug_key
local set_keymap = ____utils.set_keymap
local function mkKeybindings(input)
    local kb = {}
    for domain, bindings in pairs(input) do
        for name, binding in pairs(bindings) do
            kb[string.format("%s.%s", domain, name)] = binding
        end
        kb[string.format("%s.extra", domain)] = {}
    end
    return kb
end
local __INPUT = mkHint()({
    normal = {nohlsearch = {"<Esc>"}, save = {"<C-s>"}},
    insert = {escape = {"jk", "jj"}},
    tree = {toggle = {"<C-n>"}, focus = {"<C-b>"}},
    bufferline = {close = {"<Leader>x"}, goto_next = {"<S-l>"}, goto_prev = {"<S-h>"}},
    telescope = {
        buffers = {"<Leader>fb"},
        document_symbols = {"<Leader>fs"},
        files = {"<Leader>fF"},
        git_commits = {"<Leader>fg"},
        grep = {"<Leader>ff"},
        marks = {"<Leader>fm"},
        recent_files = {"<Leader>fo"},
        registers = {"<Leader>fr"},
        workspace_symbols = {"<Leader>fS"}
    },
    git = {
        blame_line = {"<Leader>gb"},
        goto_next_hunk = {"]g"},
        goto_prev_hunk = {"[g"},
        preview_hunk = {"<Leader>gp"},
        reset_buffer = {"<Leader>gR"},
        reset_line = {"<Leader>gr"},
        stage_buffer = {"<Leader>gS"},
        state_hunk = {"<Leader>gs"},
        undo_stage_hunk = {"<Leader>gu"}
    },
    comment = {
        insert_above = {"gcO"},
        insert_below = {"gco"},
        insert_eol = {"gcA"},
        oplead_block = {"gb"},
        oplead_line = {"gc"},
        toggle_block = {"gbc"},
        toggle_line = {"gcc"}
    },
    terminal = {toggle = {"<C-t>"}},
    lsp = {
        formatting = {"<Leader>lf"},
        goto_declaration = {"gD"},
        goto_definition = {"gd"},
        goto_next_diagnostic = {"]d"},
        goto_next_error = {"]e"},
        goto_prev_diagnostic = {"[d"},
        goto_prev_error = {"[e"},
        hover = {"K"},
        rename = {"<Leader>lr"},
        show_code_action = {"<C-k>"},
        show_diagnostic = {"ge"},
        show_document_diagnostics = {"<Leader>le"},
        show_implementation = {"gI"},
        show_references = {"gr"},
        show_signature_help = {"gk"},
        show_workspace_diagnostics = {"<Leader>lE"}
    },
    cmp = {
        close = {"<C-e>"},
        complete = {"<C-Space>"},
        confirm = {"<CR>"},
        scroll_down = {"<C-d>"},
        scroll_up = {"<C-u>"},
        select_next = {"<Tab>"},
        select_prev = {"<S-Tab>"}
    }
})
____exports.KEYBINDINGS = mkKeybindings(__INPUT)
function ____exports.map_bindings(mappings)
    local mapped = {}
    for name, val in pairs(mappings) do
        for _, lhs in ipairs(____exports.KEYBINDINGS[name]) do
            mapped[lhs] = val
        end
    end
    return mapped
end
function ____exports.apply_mappings(mappings, gopts)
    for name, source in pairs(mappings) do
        local opts = vim.tbl_extend("force", {}, source, gopts or ({}))
        for _, lhs in ipairs(____exports.KEYBINDINGS[name]) do
            set_keymap(lhs, source.cmd, opts)
        end
    end
end
function ____exports.apply_extra(key, gopts)
    for lhs, src in pairs(____exports.KEYBINDINGS[key]) do
        local opts = vim.tbl_extend("force", {}, gopts or ({}), src)
        set_keymap(lhs, src.cmd, opts)
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
function ____exports.setup_keybindings()
    ____exports.apply_mappings(____exports.COMMON_MAPPINGS)
    ____exports.apply_extra("insert.extra", {mode = "i"})
    ____exports.apply_extra("normal.extra", {mode = "n"})
end
function ____exports.update_keybindings(updater)
    apply_updater(____exports.KEYBINDINGS, updater)
end
return ____exports
