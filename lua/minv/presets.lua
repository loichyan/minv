--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____utils = require("minv.utils")
local mkHint = ____utils.mkHint
local apply_updater = ____utils.apply_updater
local function mkPresets(input)
    return input
end
local CMP_KIND = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = ""
}
local CMP_MENU = {buffer = "[BUF]", luasnip = "[SNIP]", nvim_lsp = "[LSP]", path = "[PATH]"}
local CMP_DUP = {buffer = true}
local __INPUT = mkHint()({
    spark = {},
    treesitter = {
        ensure_installed = {},
        highlight = {enable = true},
        incremental_selection = {enable = true},
        indent = {enable = true},
        context_commentstring = {enable = true, enable_autocmd = false},
        textobjects = {select = {enable = true, lookahead = true, keymaps = {af = "@function.outer", ["if"] = "@function.inner", ac = "@class.outer", ic = "@class.inner"}, include_surrounding_whitespace = false}, move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {["]m"] = "@function.outer", ["]]"] = "@class.outer"},
            goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"},
            goto_previous_start = {["[m"] = "@function.outer", ["[["] = "@class.outer"},
            goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"}
        }}
    },
    comment = {sticky = true, padding = true},
    surround = {},
    cmp = {
        sources = {{name = "nvim_lsp", priority = 3}, {name = "luasnip", priority = 2}, {name = "path", priority = 1}, {name = "buffer", priority = 0}},
        formatting = {
            fields = {"kind", "abbr", "menu"},
            format = function(entry, vim_item)
                local name = entry.source.name
                vim_item.kind = CMP_KIND[vim_item.kind]
                vim_item.menu = CMP_MENU[name]
                vim_item.dup = 1
                if CMP_DUP[name] == true then
                    vim_item.dup = 0
                end
                return vim_item
            end
        }
    },
    cmp_formatting = {kind = CMP_KIND, menu = CMP_MENU, dup = CMP_DUP},
    luasnip = {history = false, region_check_events = "InsertEnter", delete_check_events = "InsertLeave"},
    lspconfig = {server_default = {flags = {debounce_text_changes = 250}}, servers = {}, border = "rounded"},
    null_ls = {debounce = 250},
    null_ls_sources = {formatters = {prettierd = {}}, linters = {}},
    nightfox = {},
    nightfox_style = "nightfox",
    which_key = {
        plugins = {marks = true, registers = true, presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true
        }},
        operators = {gc = "Toggle line comments", gb = "Toggle block comments"},
        window = {border = "rounded"},
        layout = {align = "left"},
        ignore_missing = false,
        show_help = true,
        triggers = "auto"
    },
    which_key_groups = {["<Leader>l"] = "Lsp", ["<Leader>f"] = "Search", ["<Leader>g"] = "Git"},
    gitsigns = {signcolumn = true, preview_config = {border = "rounded"}},
    telescope = {extensions = {fzf = {fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case"}}},
    alpha = {
        header = function()
            return {
                "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝"
            }
        end,
        buttons = {
            {"n", "  New Files", "<Cmd>ene<CR>"},
            {"o", "  Recent Files", "<Cmd>Telescope oldfiles<CR>"},
            {"f", "  Find Files", "<Cmd>Telescope find_files<CR>"},
            {"w", "  Find Words", "<Cmd>Telescope live_grep<CR>"},
            {"m", "  Find Bookmarks", "<Cmd>Telescope marks<CR>"},
            {"h", "  Find Themes", "<Cmd>Telescope colorscheme<CR>"},
            {"q", "  Quit", "<Cmd>qa<CR>"}
        },
        footer = function()
            local count = 0
            for _, plug in ipairs(require("spark").plugins()) do
                if string.sub(plug[1], 1, 1) ~= "$" then
                    local state = plug.__state
                    if state == "LOADED" or state == "LOAD" or state == "POST_LOAD" then
                        count = count + 1
                    end
                end
            end
            return string.format("Neovim loaded %d plugins  ", count)
        end
    },
    bufferline = {options = {
        numbers = "none",
        diagnostics = "nvim_lsp",
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        always_show_bufferline = true,
        offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left"}}
    }},
    lualine = {
        options = {theme = "auto", section_separators = "", component_separators = "│", globalstatus = true},
        sections = {
            lualine_a = {{[1] = function()
                return " "
            end}},
            lualine_b = {{[1] = "branch"}},
            lualine_c = {{[1] = "diff"}, {[1] = "diagnostics", sources = {"nvim_diagnostic"}}},
            lualine_x = {{[1] = "encoding", fmt = string.upper}, {[1] = "fileformat"}, {[1] = "filetype"}},
            lualine_y = {{[1] = "progress"}},
            lualine_z = {{[1] = "location"}}
        },
        extensions = {"nvim-tree", "toggleterm", "quickfix"}
    },
    nvim_tree = {
        respect_buf_cwd = true,
        sync_root_with_cwd = true,
        update_focused_file = {enable = true, update_root = true},
        actions = {open_file = {resize_window = true}},
        git = {enable = true, ignore = false, timeout = 500},
        filters = {custom = {"^.git$", "^.cache$", "^node_modules$"}}
    },
    toggleterm = {direction = "float", float_opts = {border = "rounded"}}
})
____exports.PRESETS = mkPresets(__INPUT)
function ____exports.update_preset(updater)
    apply_updater(____exports.PRESETS, updater)
end
return ____exports
