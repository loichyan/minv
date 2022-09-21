--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____keybindings = require("minv.keybindings")
local apply_extra = ____keybindings.apply_extra
local apply_mappings = ____keybindings.apply_mappings
local mkPlugKeySrc = ____keybindings.mkPlugKeySrc
local ____presets = require("minv.presets")
local PRESETS = ____presets.PRESETS
local ____utils = require("minv.utils")
local autocmd = ____utils.autocmd
local deep_merge = ____utils.deep_merge
local MAPPINGS_GIT = {
    ["git.blame_line"] = {cmd = "<Cmd>Gitsigns blame_line<CR>", desc = "Blame line"},
    ["git.goto_next_hunk"] = {cmd = "<Cmd>Gitsigns next_hunk<CR>", desc = "Goto next hunk"},
    ["git.goto_prev_hunk"] = {cmd = "<Cmd>Gitsigns prev_hunk<CR>", desc = "Goto prev hunk"},
    ["git.preview_hunk"] = {cmd = "<Cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk"},
    ["git.reset_buffer"] = {cmd = "<Cmd>Gitsigns reset_buffer<CR>", desc = "Reset buffer"},
    ["git.reset_line"] = {cmd = "<Cmd>Gitsigns reset_hunk<CR>", desc = "Reset hunk"},
    ["git.stage_buffer"] = {cmd = "<Cmd>Gitsigns stage_buffer<CR>", desc = "Stage buffer"},
    ["git.state_hunk"] = {cmd = "<Cmd>Gitsigns stage_hunk<CR>", desc = "Stage hunk"},
    ["git.undo_stage_hunk"] = {cmd = "<Cmd>Gitsigns undo_stage_hunk<CR>", desc = "Undo stage hunk"}
}
local MAPPINGS_TELESCOPE = {
    ["telescope.buffers"] = {cmd = "<Cmd>Telescope buffers<CR>", desc = "Search buffers"},
    ["telescope.document_symbols"] = {cmd = "<Cmd>Telescope lsp_document_symbols<CR>", desc = "Search document symbols"},
    ["telescope.files"] = {cmd = "<Cmd>Telescope find_files<CR>", desc = "Search files"},
    ["telescope.git_commits"] = {cmd = "<Cmd>Telescope git_commits<CR>", desc = "Search git commits"},
    ["telescope.grep"] = {cmd = "<Cmd>Telescope live_grep<CR>", desc = "Search strings"},
    ["telescope.marks"] = {cmd = "<Cmd>Telescope marks<CR>", desc = "Search marks"},
    ["telescope.recent_files"] = {cmd = "<Cmd>Telescope oldfiles<CR>", desc = "Search recent files"},
    ["telescope.registers"] = {cmd = "<Cmd>Telescope registers<CR>", desc = "Search registers"},
    ["telescope.workspace_symbols"] = {cmd = "<Cmd>Telescope lsp_workspace_symbols<CR>", desc = "Search workspace symbols"}
}
local MAPPINGS_BUFFER = {["bufferline.close"] = {cmd = "<Cmd>bdelete<CR>", desc = "Close buffer"}, ["bufferline.goto_next"] = {cmd = "<Cmd>BufferLineCycleNext<CR>", desc = "Goto next buffer"}, ["bufferline.goto_prev"] = {cmd = "<Cmd>BufferLineCyclePrev<CR>", desc = "Goto prev buffer"}}
local MAPPINGS_TREE = {["tree.toggle"] = {cmd = "<Cmd>NvimTreeToggle<CR>", desc = "Toggle tree"}, ["tree.focus"] = {cmd = "<Cmd>NvimTreeFocus<CR>", desc = "Focus tree"}}
local MAPPINGS_TOGGLETERM = mkPlugKeySrc({["terminal.toggle"] = "Toggle terminal"})
function ____exports.setup_which_key()
    local which_key = require("which-key")
    which_key.setup(PRESETS.which_key)
    local groups = {}
    for key, name in pairs(PRESETS.which_key_groups) do
        groups[key] = {name = name}
    end
    which_key.register(groups)
end
function ____exports.setup_gitsigns()
    require("gitsigns").setup(PRESETS.gitsigns)
    apply_mappings(MAPPINGS_GIT)
    apply_extra("git.extra", {mode = "n"})
end
function ____exports.setup_telescope()
    local telescope = require("telescope")
    telescope.setup(PRESETS.telescope)
    telescope.load_extension("fzf")
    apply_mappings(MAPPINGS_TELESCOPE)
    apply_extra("telescope.extra", {mode = "n"})
end
function ____exports.setup_alpha()
    local preset = PRESETS.alpha
    local dashboard = require("alpha.themes.dashboard")
    local header = dashboard.section.header
    local buttons = dashboard.section.buttons
    local footer = dashboard.section.footer
    header.val = preset.header()
    header.opts.hl = "DashboardHeader"
    buttons.val = {}
    for _, val in ipairs(preset.buttons) do
        local btn = dashboard.button(unpack(val))
        btn.opts.hl = "DashboardCenter"
        btn.opts.hl_shortcut = "DashboardShortcut"
        table.insert(buttons.val, btn)
    end
    footer.val = preset.footer()
    footer.opts.hl = "DashboardFooter"
    require("alpha").setup(dashboard.config)
    autocmd(
        "User",
        function(____bindingPattern0)
            local buf
            buf = ____bindingPattern0.buf
            vim.cmd("set showtabline=0")
            autocmd("BufUnload", "set showtabline=2", {once = true, buffer = buf})
        end,
        {pattern = "AlphaReady"}
    )
end
function ____exports.setup_bufferline()
    require("bufferline").setup(PRESETS.bufferline)
    apply_mappings(MAPPINGS_BUFFER)
    apply_extra("bufferline.extra", {mode = "n"})
end
function ____exports.setup_lualine()
    require("lualine").setup(PRESETS.lualine)
end
function ____exports.setup_nvim_tree()
    require("nvim-tree").setup(PRESETS.nvim_tree)
    apply_mappings(MAPPINGS_TREE)
    apply_extra("tree.extra", {mode = "n"})
end
function ____exports.setup_toggleterm()
    local preset = PRESETS.toggleterm
    require("toggleterm").setup(deep_merge(
        "keep",
        {
            insert_mappings = true,
            terminal_mappings = true,
            open_mapping = MAPPINGS_TOGGLETERM["terminal.toggle"].cmd,
            on_open = function(term)
                apply_mappings(MAPPINGS_TOGGLETERM, {mode = "t", noremap = false, buffer = term.bufnr})
                apply_extra("terminal.extra", {mode = "t", buffer = term.bufnr})
                local on_open = preset.on_open
                if on_open ~= nil then
                    on_open(term)
                end
            end
        },
        preset
    ))
    apply_mappings(MAPPINGS_TOGGLETERM, {noremap = false})
end
return ____exports
