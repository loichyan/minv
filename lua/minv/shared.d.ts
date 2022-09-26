/// <reference types="@typescript-to-lua/language-extensions" />
import { Plug } from "./plugins";
export declare const ALL_PLUGINS: LuaMap<string, Plug>;
export declare type MINV = typeof MINV;
export declare const MINV: {
    config: import("./config").Config;
    plugins: {
        essional: {
            1: {
                impatient: Plug;
                $setup_impatient: Plug;
                spark: Plug;
                plenary: Plug;
                web_devicons: Plug;
            } & {
                $pre_setup_impatient: Plug;
                $post_setup_impatient: Plug;
            } & {
                [k: string]: Plug | undefined;
            };
        } & import("./plugins").GroupSpec;
        treesitter: {
            1: {
                treesitter: Plug;
                $setup_treesitter: Plug;
                ts_context_commentstring: Plug;
                comment: Plug;
                $setup_comment: Plug;
                ts_textobjects: Plug;
                surround: Plug;
                $setup_surround: Plug;
            } & {
                $pre_setup_treesitter: Plug;
                $post_setup_treesitter: Plug;
                $pre_setup_comment: Plug;
                $post_setup_comment: Plug;
                $pre_setup_surround: Plug;
                $post_setup_surround: Plug;
            } & {
                [k: string]: Plug | undefined;
            };
        } & import("./plugins").GroupSpec;
        cmp: {
            1: {
                cmp: Plug;
                cmp_luasnip: Plug;
                cmp_nvim_lsp: Plug;
                cmp_path: Plug;
                cmp_buffer: Plug;
                friendly_snippets: Plug;
                luasnip: Plug;
                $setup_cmp: Plug;
            } & {
                $pre_setup_cmp: Plug;
                $post_setup_cmp: Plug;
            } & {
                [k: string]: Plug | undefined;
            };
        } & import("./plugins").GroupSpec;
        lsp: {
            1: {
                lspconfig: Plug;
                $setup_lspconfig: Plug;
                null_ls: Plug;
                $setup_null_ls: Plug;
            } & {
                $pre_setup_lspconfig: Plug;
                $post_setup_lspconfig: Plug;
                $pre_setup_null_ls: Plug;
                $post_setup_null_ls: Plug;
            } & {
                [k: string]: Plug | undefined;
            };
        } & import("./plugins").GroupSpec;
        ui: {
            1: {
                nightfox: Plug;
                $setup_nightfox: Plug;
                whick_key: Plug;
                $setup_which_key: Plug;
                gitsigns: Plug;
                $setup_gitsigns: Plug;
                telescope: Plug;
                telescope_fzf_native: Plug;
                $setup_telescope: Plug;
                alpha: Plug;
                $setup_alpha: Plug;
                bufferline: Plug;
                $setup_bufferline: Plug;
                lualine: Plug;
                $setup_lualine: Plug;
                nvim_tree: Plug;
                $setup_nvim_tree: Plug;
                toggleterm: Plug;
                $setup_toggleterm: Plug;
            } & {
                $pre_setup_nightfox: Plug;
                $post_setup_nightfox: Plug;
                $pre_setup_which_key: Plug;
                $post_setup_which_key: Plug;
                $pre_setup_gitsigns: Plug;
                $post_setup_gitsigns: Plug;
                $pre_setup_telescope: Plug;
                $post_setup_telescope: Plug;
                $pre_setup_alpha: Plug;
                $post_setup_alpha: Plug;
                $pre_setup_bufferline: Plug;
                $post_setup_bufferline: Plug;
                $pre_setup_lualine: Plug;
                $post_setup_lualine: Plug;
                $pre_setup_nvim_tree: Plug;
                $post_setup_nvim_tree: Plug;
                $pre_setup_toggleterm: Plug;
                $post_setup_toggleterm: Plug;
            } & {
                [k: string]: Plug | undefined;
            };
        } & import("./plugins").GroupSpec;
        extra: {
            1: {} & {} & {
                [k: string]: Plug | undefined;
            };
        } & import("./plugins").GroupSpec;
    };
    presets: {
        spark: import("./presets").SparkConfig & {
            [k: string]: any;
            [k: number]: any;
        };
        treesitter: {
            ensure_installed: {};
            highlight: {
                enable: boolean;
            };
            incremental_selection: {
                enable: boolean;
            };
            indent: {
                enable: boolean;
            };
            context_commentstring: {
                enable: boolean;
                enable_autocmd: boolean;
            };
            textobjects: {
                select: {
                    enable: boolean;
                    lookahead: boolean;
                    keymaps: {
                        af: string;
                        if: string;
                        ac: string;
                        ic: string;
                    };
                    include_surrounding_whitespace: boolean;
                };
                move: {
                    enable: boolean;
                    set_jumps: boolean;
                    goto_next_start: {
                        "]m": string;
                        "]]": string;
                    };
                    goto_next_end: {
                        "]M": string;
                        "][": string;
                    };
                    goto_previous_start: {
                        "[m": string;
                        "[[": string;
                    };
                    goto_previous_end: {
                        "[M": string;
                        "[]": string;
                    };
                };
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        comment: {
            sticky: boolean;
            padding: boolean;
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        surround: {
            [k: string]: any;
            [k: number]: any;
        };
        cmp: {
            sources: {
                name: string;
                priority: number;
            }[];
            formatting: {
                fields: string[];
                format: (this: void, entry: any, vim_item: any) => any;
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        cmp_formatting: {
            kind: LuaMap<string, string>;
            menu: LuaMap<string, string>;
            dup: LuaMap<string, boolean>;
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        luasnip: {
            history: boolean;
            region_check_events: string;
            delete_check_events: string;
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        lspconfig: {
            server_default: {
                flags: {
                    debounce_text_changes: number;
                };
            };
            servers: {
                [k: string]: AnyTbl;
            };
            border: string;
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        null_ls: {
            debounce: number;
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        null_ls_sources: {
            formatters: {
                [k: string]: {};
            };
            linters: {
                [k: string]: {};
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        nightfox: {
            [k: string]: any;
            [k: number]: any;
        };
        nightfox_style: string & {
            [k: string]: any;
            [k: number]: any;
        };
        which_key: {
            plugins: {
                marks: boolean;
                registers: boolean;
                presets: {
                    operators: boolean;
                    motions: boolean;
                    text_objects: boolean;
                    windows: boolean;
                    nav: boolean;
                    z: boolean;
                    g: boolean;
                };
            };
            operators: {
                gc: string;
                gb: string;
            };
            window: {
                border: string;
            };
            layout: {
                align: string;
            };
            ignore_missing: boolean;
            show_help: boolean;
            triggers: string;
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        which_key_groups: {
            "<Leader>l": string;
            "<Leader>f": string;
            "<Leader>g": string;
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        gitsigns: {
            signcolumn: boolean;
            preview_config: {
                border: string;
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        telescope: {
            extensions: {
                fzf: {
                    fuzzy: boolean;
                    override_generic_sorter: boolean;
                    override_file_sorter: boolean;
                    case_mode: string;
                };
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        alpha: {
            header: (this: void) => string[];
            buttons: string[][];
            footer: (this: void) => string;
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        bufferline: {
            options: {
                numbers: string;
                diagnostics: string;
                show_buffer_icons: boolean;
                show_buffer_close_icons: boolean;
                show_close_icon: boolean;
                always_show_bufferline: boolean;
                offsets: {
                    filetype: string;
                    text: string;
                    text_align: string;
                }[];
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        lualine: {
            options: {
                theme: string;
                section_separators: string;
                component_separators: string;
                globalstatus: boolean;
            };
            sections: {
                lualine_a: {
                    1(this: void): " ";
                }[];
                lualine_b: {
                    1: string;
                }[];
                lualine_c: ({
                    1: string;
                    sources?: undefined;
                } | {
                    1: string;
                    sources: string[];
                })[];
                lualine_x: ({
                    1: string;
                    fmt: typeof string.upper;
                } | {
                    1: string;
                    fmt?: undefined;
                })[];
                lualine_y: {
                    1: string;
                }[];
                lualine_z: {
                    1: string;
                }[];
            };
            extensions: string[];
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        nvim_tree: {
            respect_buf_cwd: boolean;
            sync_root_with_cwd: boolean;
            update_focused_file: {
                enable: boolean;
                update_root: boolean;
            };
            actions: {
                open_file: {
                    resize_window: boolean;
                };
            };
            git: {
                enable: boolean;
                ignore: boolean;
                timeout: number;
            };
            filters: {
                custom: string[];
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        };
        toggleterm: {
            direction: string;
            float_opts: {
                border: string;
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        };
    };
    keybindings: {
        "normal.nohlsearch": string[];
        "normal.save": string[];
        "git.blame_line": string[];
        "git.goto_next_hunk": string[];
        "git.goto_prev_hunk": string[];
        "git.preview_hunk": string[];
        "git.reset_buffer": string[];
        "git.reset_line": string[];
        "git.stage_buffer": string[];
        "git.state_hunk": string[];
        "git.undo_stage_hunk": string[];
        "insert.escape": string[];
        "tree.toggle": string[];
        "tree.focus": string[];
        "bufferline.close": string[];
        "bufferline.goto_next": string[];
        "bufferline.goto_prev": string[];
        "telescope.buffers": string[];
        "telescope.document_symbols": string[];
        "telescope.files": string[];
        "telescope.git_commits": string[];
        "telescope.grep": string[];
        "telescope.marks": string[];
        "telescope.recent_files": string[];
        "telescope.registers": string[];
        "telescope.workspace_symbols": string[];
        "comment.insert_above": string[];
        "comment.insert_below": string[];
        "comment.insert_eol": string[];
        "comment.oplead_block": string[];
        "comment.oplead_line": string[];
        "comment.toggle_block": string[];
        "comment.toggle_line": string[];
        "terminal.toggle": string[];
        "lsp.formatting": string[];
        "lsp.goto_declaration": string[];
        "lsp.goto_definition": string[];
        "lsp.goto_next_diagnostic": string[];
        "lsp.goto_next_error": string[];
        "lsp.goto_prev_diagnostic": string[];
        "lsp.goto_prev_error": string[];
        "lsp.hover": string[];
        "lsp.rename": string[];
        "lsp.show_code_action": string[];
        "lsp.show_diagnostic": string[];
        "lsp.show_document_diagnostics": string[];
        "lsp.show_implementation": string[];
        "lsp.show_references": string[];
        "lsp.show_signature_help": string[];
        "lsp.show_workspace_diagnostics": string[];
        "cmp.close": string[];
        "cmp.complete": string[];
        "cmp.confirm": string[];
        "cmp.scroll_down": string[];
        "cmp.scroll_up": string[];
        "cmp.select_next": string[];
        "cmp.select_prev": string[];
    } & {
        "normal.extra": {
            [k: string]: import("./keybindings").Source;
        };
        "git.extra": {
            [k: string]: import("./keybindings").Source;
        };
        "insert.extra": {
            [k: string]: import("./keybindings").Source;
        };
        "tree.extra": {
            [k: string]: import("./keybindings").Source;
        };
        "bufferline.extra": {
            [k: string]: import("./keybindings").Source;
        };
        "telescope.extra": {
            [k: string]: import("./keybindings").Source;
        };
        "comment.extra": {
            [k: string]: import("./keybindings").Source;
        };
        "terminal.extra": {
            [k: string]: import("./keybindings").Source;
        };
        "lsp.extra": {
            [k: string]: import("./keybindings").Source;
        };
        "cmp.extra": {
            [k: string]: import("./keybindings").Source;
        };
    };
    settings: {
        g: {
            mapleader: string;
            markdown_fenced_languages: string[];
        };
        o: {
            clipboard: string;
            mouse: string;
            timeoutlen: number;
            updatetime: number;
            autoread: boolean;
            expandtab: boolean;
            tabstop: number;
            shiftwidth: number;
            autoindent: boolean;
            hlsearch: boolean;
            ignorecase: boolean;
            smartcase: boolean;
            swapfile: boolean;
            undofile: boolean;
            number: boolean;
            relativenumber: boolean;
            hidden: boolean;
            title: boolean;
            signcolumn: string;
            termguicolors: boolean;
            showmode: boolean;
            splitbelow: boolean;
            splitright: boolean;
        };
    };
    autocmds: {
        hl_yank: {
            enable: boolean;
            pattern: string;
            highgroup: string;
            timeout: number;
        };
        format_on_save: {
            enable: boolean;
            pattern: string;
            timeout: undefined;
        };
        close: {
            enable: boolean;
            key: string;
            filetype: string[];
        };
        trim_spaces: {
            enable: boolean;
            pattern: string;
        };
        auto_resize: {
            enable: boolean;
            pattern: string;
        };
        ruler: {
            enable: boolean;
            offsets: Record<string, number>;
        };
    };
    get_plugin(name: string): Plug | undefined;
    set_keymap: (lhs: string, cmd: import("./utils").KeymapCmd, opts: import("./utils").KeymapOpts) => void;
    set_autocmd: (event: string | string[], cmd: string | ((this: void, args: vim.autocmd_cb_args) => true | void), opts?: Omit<vim.autocmd_opts, "callback" | "command"> | undefined) => void;
    update_plugins: (input: {
        essional?: Partial<{
            1: Record<string, Plug> & Partial<{
                $pre_setup_impatient: Plug;
                $post_setup_impatient: Plug;
            }>;
        } & import("./plugins").GroupSpec> | undefined;
        treesitter?: Partial<{
            1: Record<string, Plug> & Partial<{
                $pre_setup_treesitter: Plug;
                $post_setup_treesitter: Plug;
                $pre_setup_comment: Plug;
                $post_setup_comment: Plug;
                $pre_setup_surround: Plug;
                $post_setup_surround: Plug;
            }>;
        } & import("./plugins").GroupSpec> | undefined;
        cmp?: Partial<{
            1: Record<string, Plug> & Partial<{
                $pre_setup_cmp: Plug;
                $post_setup_cmp: Plug;
            }>;
        } & import("./plugins").GroupSpec> | undefined;
        lsp?: Partial<{
            1: Record<string, Plug> & Partial<{
                $pre_setup_lspconfig: Plug;
                $post_setup_lspconfig: Plug;
                $pre_setup_null_ls: Plug;
                $post_setup_null_ls: Plug;
            }>;
        } & import("./plugins").GroupSpec> | undefined;
        ui?: Partial<{
            1: Record<string, Plug> & Partial<{
                $pre_setup_nightfox: Plug;
                $post_setup_nightfox: Plug;
                $pre_setup_which_key: Plug;
                $post_setup_which_key: Plug;
                $pre_setup_gitsigns: Plug;
                $post_setup_gitsigns: Plug;
                $pre_setup_telescope: Plug;
                $post_setup_telescope: Plug;
                $pre_setup_alpha: Plug;
                $post_setup_alpha: Plug;
                $pre_setup_bufferline: Plug;
                $post_setup_bufferline: Plug;
                $pre_setup_lualine: Plug;
                $post_setup_lualine: Plug;
                $pre_setup_nvim_tree: Plug;
                $post_setup_nvim_tree: Plug;
                $pre_setup_toggleterm: Plug;
                $post_setup_toggleterm: Plug;
            }>;
        } & import("./plugins").GroupSpec> | undefined;
        extra?: Partial<{
            1: Record<string, Plug> & Partial<{}>;
        } & import("./plugins").GroupSpec> | undefined;
    }) => void;
    update_keybindings: (updater: {
        "normal.nohlsearch"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "normal.save"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "git.blame_line"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "git.goto_next_hunk"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "git.goto_prev_hunk"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "git.preview_hunk"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "git.reset_buffer"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "git.reset_line"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "git.stage_buffer"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "git.state_hunk"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "git.undo_stage_hunk"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "insert.escape"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "tree.toggle"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "tree.focus"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "bufferline.close"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "bufferline.goto_next"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "bufferline.goto_prev"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "telescope.buffers"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "telescope.document_symbols"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "telescope.files"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "telescope.git_commits"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "telescope.grep"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "telescope.marks"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "telescope.recent_files"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "telescope.registers"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "telescope.workspace_symbols"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "comment.insert_above"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "comment.insert_below"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "comment.insert_eol"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "comment.oplead_block"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "comment.oplead_line"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "comment.toggle_block"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "comment.toggle_line"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "terminal.toggle"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.formatting"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.goto_declaration"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.goto_definition"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.goto_next_diagnostic"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.goto_next_error"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.goto_prev_diagnostic"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.goto_prev_error"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.hover"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.rename"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.show_code_action"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.show_diagnostic"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.show_document_diagnostics"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.show_implementation"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.show_references"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.show_signature_help"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "lsp.show_workspace_diagnostics"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "cmp.close"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "cmp.complete"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "cmp.confirm"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "cmp.scroll_down"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "cmp.scroll_up"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "cmp.select_next"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "cmp.select_prev"?: ({
            $set: string[];
        } | {
            $merge: (string | undefined)[];
        } | {
            $concat: string[];
        } | {
            $insert: [number, string];
        } | {
            $batch: ({
                $set: string[];
            } | {
                $merge: (string | undefined)[];
            } | {
                $concat: string[];
            } | {
                $insert: [number, string];
            } | any)[];
        }) | (string | ({
            $set: string;
        } | {
            $merge: never;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: string;
            } | {
                $merge: never;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | undefined)[] | undefined;
        "normal.extra"?: ({
            $set: {
                [k: string]: import("./keybindings").Source;
            };
        } | {
            $merge: Partial<{
                [k: string]: import("./keybindings").Source;
            }>;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: {
                    [k: string]: import("./keybindings").Source;
                };
            } | {
                $merge: Partial<{
                    [k: string]: import("./keybindings").Source;
                }>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | {
            [x: string]: ({
                $set: import("./keybindings").Source;
            } | {
                $merge: Partial<import("./keybindings").Source>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | {
                $batch: ({
                    $set: import("./keybindings").Source;
                } | {
                    $merge: Partial<import("./keybindings").Source>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | any)[];
            }) | {
                cmd?: ({
                    $set: import("./utils").KeymapCmd;
                } | {
                    $merge: Partial<(this: void) => void>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: import("./utils").KeymapCmd;
                    } | {
                        $merge: Partial<(this: void) => void>;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<import("./utils").KeymapCmd, true> | undefined;
                mode?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
                buffer?: ({
                    $set: number | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: number | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<number | undefined, true>;
                script?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                noremap?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                nowait?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                silent?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                expr?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                unique?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                desc?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
            } | undefined;
        } | undefined;
        "git.extra"?: ({
            $set: {
                [k: string]: import("./keybindings").Source;
            };
        } | {
            $merge: Partial<{
                [k: string]: import("./keybindings").Source;
            }>;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: {
                    [k: string]: import("./keybindings").Source;
                };
            } | {
                $merge: Partial<{
                    [k: string]: import("./keybindings").Source;
                }>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | {
            [x: string]: ({
                $set: import("./keybindings").Source;
            } | {
                $merge: Partial<import("./keybindings").Source>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | {
                $batch: ({
                    $set: import("./keybindings").Source;
                } | {
                    $merge: Partial<import("./keybindings").Source>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | any)[];
            }) | {
                cmd?: ({
                    $set: import("./utils").KeymapCmd;
                } | {
                    $merge: Partial<(this: void) => void>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: import("./utils").KeymapCmd;
                    } | {
                        $merge: Partial<(this: void) => void>;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<import("./utils").KeymapCmd, true> | undefined;
                mode?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
                buffer?: ({
                    $set: number | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: number | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<number | undefined, true>;
                script?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                noremap?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                nowait?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                silent?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                expr?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                unique?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                desc?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
            } | undefined;
        } | undefined;
        "insert.extra"?: ({
            $set: {
                [k: string]: import("./keybindings").Source;
            };
        } | {
            $merge: Partial<{
                [k: string]: import("./keybindings").Source;
            }>;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: {
                    [k: string]: import("./keybindings").Source;
                };
            } | {
                $merge: Partial<{
                    [k: string]: import("./keybindings").Source;
                }>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | {
            [x: string]: ({
                $set: import("./keybindings").Source;
            } | {
                $merge: Partial<import("./keybindings").Source>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | {
                $batch: ({
                    $set: import("./keybindings").Source;
                } | {
                    $merge: Partial<import("./keybindings").Source>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | any)[];
            }) | {
                cmd?: ({
                    $set: import("./utils").KeymapCmd;
                } | {
                    $merge: Partial<(this: void) => void>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: import("./utils").KeymapCmd;
                    } | {
                        $merge: Partial<(this: void) => void>;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<import("./utils").KeymapCmd, true> | undefined;
                mode?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
                buffer?: ({
                    $set: number | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: number | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<number | undefined, true>;
                script?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                noremap?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                nowait?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                silent?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                expr?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                unique?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                desc?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
            } | undefined;
        } | undefined;
        "tree.extra"?: ({
            $set: {
                [k: string]: import("./keybindings").Source;
            };
        } | {
            $merge: Partial<{
                [k: string]: import("./keybindings").Source;
            }>;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: {
                    [k: string]: import("./keybindings").Source;
                };
            } | {
                $merge: Partial<{
                    [k: string]: import("./keybindings").Source;
                }>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | {
            [x: string]: ({
                $set: import("./keybindings").Source;
            } | {
                $merge: Partial<import("./keybindings").Source>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | {
                $batch: ({
                    $set: import("./keybindings").Source;
                } | {
                    $merge: Partial<import("./keybindings").Source>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | any)[];
            }) | {
                cmd?: ({
                    $set: import("./utils").KeymapCmd;
                } | {
                    $merge: Partial<(this: void) => void>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: import("./utils").KeymapCmd;
                    } | {
                        $merge: Partial<(this: void) => void>;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<import("./utils").KeymapCmd, true> | undefined;
                mode?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
                buffer?: ({
                    $set: number | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: number | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<number | undefined, true>;
                script?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                noremap?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                nowait?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                silent?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                expr?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                unique?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                desc?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
            } | undefined;
        } | undefined;
        "bufferline.extra"?: ({
            $set: {
                [k: string]: import("./keybindings").Source;
            };
        } | {
            $merge: Partial<{
                [k: string]: import("./keybindings").Source;
            }>;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: {
                    [k: string]: import("./keybindings").Source;
                };
            } | {
                $merge: Partial<{
                    [k: string]: import("./keybindings").Source;
                }>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | {
            [x: string]: ({
                $set: import("./keybindings").Source;
            } | {
                $merge: Partial<import("./keybindings").Source>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | {
                $batch: ({
                    $set: import("./keybindings").Source;
                } | {
                    $merge: Partial<import("./keybindings").Source>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | any)[];
            }) | {
                cmd?: ({
                    $set: import("./utils").KeymapCmd;
                } | {
                    $merge: Partial<(this: void) => void>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: import("./utils").KeymapCmd;
                    } | {
                        $merge: Partial<(this: void) => void>;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<import("./utils").KeymapCmd, true> | undefined;
                mode?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
                buffer?: ({
                    $set: number | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: number | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<number | undefined, true>;
                script?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                noremap?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                nowait?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                silent?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                expr?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                unique?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                desc?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
            } | undefined;
        } | undefined;
        "telescope.extra"?: ({
            $set: {
                [k: string]: import("./keybindings").Source;
            };
        } | {
            $merge: Partial<{
                [k: string]: import("./keybindings").Source;
            }>;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: {
                    [k: string]: import("./keybindings").Source;
                };
            } | {
                $merge: Partial<{
                    [k: string]: import("./keybindings").Source;
                }>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | {
            [x: string]: ({
                $set: import("./keybindings").Source;
            } | {
                $merge: Partial<import("./keybindings").Source>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | {
                $batch: ({
                    $set: import("./keybindings").Source;
                } | {
                    $merge: Partial<import("./keybindings").Source>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | any)[];
            }) | {
                cmd?: ({
                    $set: import("./utils").KeymapCmd;
                } | {
                    $merge: Partial<(this: void) => void>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: import("./utils").KeymapCmd;
                    } | {
                        $merge: Partial<(this: void) => void>;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<import("./utils").KeymapCmd, true> | undefined;
                mode?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
                buffer?: ({
                    $set: number | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: number | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<number | undefined, true>;
                script?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                noremap?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                nowait?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                silent?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                expr?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                unique?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                desc?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
            } | undefined;
        } | undefined;
        "comment.extra"?: ({
            $set: {
                [k: string]: import("./keybindings").Source;
            };
        } | {
            $merge: Partial<{
                [k: string]: import("./keybindings").Source;
            }>;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: {
                    [k: string]: import("./keybindings").Source;
                };
            } | {
                $merge: Partial<{
                    [k: string]: import("./keybindings").Source;
                }>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | {
            [x: string]: ({
                $set: import("./keybindings").Source;
            } | {
                $merge: Partial<import("./keybindings").Source>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | {
                $batch: ({
                    $set: import("./keybindings").Source;
                } | {
                    $merge: Partial<import("./keybindings").Source>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | any)[];
            }) | {
                cmd?: ({
                    $set: import("./utils").KeymapCmd;
                } | {
                    $merge: Partial<(this: void) => void>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: import("./utils").KeymapCmd;
                    } | {
                        $merge: Partial<(this: void) => void>;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<import("./utils").KeymapCmd, true> | undefined;
                mode?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
                buffer?: ({
                    $set: number | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: number | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<number | undefined, true>;
                script?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                noremap?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                nowait?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                silent?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                expr?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                unique?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                desc?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
            } | undefined;
        } | undefined;
        "terminal.extra"?: ({
            $set: {
                [k: string]: import("./keybindings").Source;
            };
        } | {
            $merge: Partial<{
                [k: string]: import("./keybindings").Source;
            }>;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: {
                    [k: string]: import("./keybindings").Source;
                };
            } | {
                $merge: Partial<{
                    [k: string]: import("./keybindings").Source;
                }>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | {
            [x: string]: ({
                $set: import("./keybindings").Source;
            } | {
                $merge: Partial<import("./keybindings").Source>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | {
                $batch: ({
                    $set: import("./keybindings").Source;
                } | {
                    $merge: Partial<import("./keybindings").Source>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | any)[];
            }) | {
                cmd?: ({
                    $set: import("./utils").KeymapCmd;
                } | {
                    $merge: Partial<(this: void) => void>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: import("./utils").KeymapCmd;
                    } | {
                        $merge: Partial<(this: void) => void>;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<import("./utils").KeymapCmd, true> | undefined;
                mode?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
                buffer?: ({
                    $set: number | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: number | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<number | undefined, true>;
                script?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                noremap?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                nowait?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                silent?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                expr?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                unique?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                desc?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
            } | undefined;
        } | undefined;
        "lsp.extra"?: ({
            $set: {
                [k: string]: import("./keybindings").Source;
            };
        } | {
            $merge: Partial<{
                [k: string]: import("./keybindings").Source;
            }>;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: {
                    [k: string]: import("./keybindings").Source;
                };
            } | {
                $merge: Partial<{
                    [k: string]: import("./keybindings").Source;
                }>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | {
            [x: string]: ({
                $set: import("./keybindings").Source;
            } | {
                $merge: Partial<import("./keybindings").Source>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | {
                $batch: ({
                    $set: import("./keybindings").Source;
                } | {
                    $merge: Partial<import("./keybindings").Source>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | any)[];
            }) | {
                cmd?: ({
                    $set: import("./utils").KeymapCmd;
                } | {
                    $merge: Partial<(this: void) => void>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: import("./utils").KeymapCmd;
                    } | {
                        $merge: Partial<(this: void) => void>;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<import("./utils").KeymapCmd, true> | undefined;
                mode?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
                buffer?: ({
                    $set: number | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: number | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<number | undefined, true>;
                script?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                noremap?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                nowait?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                silent?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                expr?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                unique?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                desc?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
            } | undefined;
        } | undefined;
        "cmp.extra"?: ({
            $set: {
                [k: string]: import("./keybindings").Source;
            };
        } | {
            $merge: Partial<{
                [k: string]: import("./keybindings").Source;
            }>;
        } | {
            $concat: never;
        } | {
            $insert: [number, never];
        } | {
            $batch: ({
                $set: {
                    [k: string]: import("./keybindings").Source;
                };
            } | {
                $merge: Partial<{
                    [k: string]: import("./keybindings").Source;
                }>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | any)[];
        }) | {
            [x: string]: ({
                $set: import("./keybindings").Source;
            } | {
                $merge: Partial<import("./keybindings").Source>;
            } | {
                $concat: never;
            } | {
                $insert: [number, never];
            } | {
                $batch: ({
                    $set: import("./keybindings").Source;
                } | {
                    $merge: Partial<import("./keybindings").Source>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | any)[];
            }) | {
                cmd?: ({
                    $set: import("./utils").KeymapCmd;
                } | {
                    $merge: Partial<(this: void) => void>;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: import("./utils").KeymapCmd;
                    } | {
                        $merge: Partial<(this: void) => void>;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<import("./utils").KeymapCmd, true> | undefined;
                mode?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
                buffer?: ({
                    $set: number | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: number | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<number | undefined, true>;
                script?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                noremap?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                nowait?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                silent?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                expr?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                unique?: ({
                    $set: boolean | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: boolean | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<boolean | undefined, true>;
                desc?: ({
                    $set: string | undefined;
                } | {
                    $merge: never;
                } | {
                    $concat: never;
                } | {
                    $insert: [number, never];
                } | {
                    $batch: ({
                        $set: string | undefined;
                    } | {
                        $merge: never;
                    } | {
                        $concat: never;
                    } | {
                        $insert: [number, never];
                    } | any)[];
                }) | import("./utils").MkUpdater<string | undefined, true>;
            } | undefined;
        } | undefined;
    }) => void;
    update_preset: (updater: {
        spark?: import("./utils").MkUpdater<import("./presets").SparkConfig & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        treesitter?: import("./utils").MkUpdater<{
            ensure_installed: {};
            highlight: {
                enable: boolean;
            };
            incremental_selection: {
                enable: boolean;
            };
            indent: {
                enable: boolean;
            };
            context_commentstring: {
                enable: boolean;
                enable_autocmd: boolean;
            };
            textobjects: {
                select: {
                    enable: boolean;
                    lookahead: boolean;
                    keymaps: {
                        af: string;
                        if: string;
                        ac: string;
                        ic: string;
                    };
                    include_surrounding_whitespace: boolean;
                };
                move: {
                    enable: boolean;
                    set_jumps: boolean;
                    goto_next_start: {
                        "]m": string;
                        "]]": string;
                    };
                    goto_next_end: {
                        "]M": string;
                        "][": string;
                    };
                    goto_previous_start: {
                        "[m": string;
                        "[[": string;
                    };
                    goto_previous_end: {
                        "[M": string;
                        "[]": string;
                    };
                };
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        comment?: import("./utils").MkUpdater<{
            sticky: boolean;
            padding: boolean;
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        surround?: import("./utils").MkUpdater<{
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        cmp?: import("./utils").MkUpdater<{
            sources: {
                name: string;
                priority: number;
            }[];
            formatting: {
                fields: string[];
                format: (this: void, entry: any, vim_item: any) => any;
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        cmp_formatting?: import("./utils").MkUpdater<{
            kind: LuaMap<string, string>;
            menu: LuaMap<string, string>;
            dup: LuaMap<string, boolean>;
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        luasnip?: import("./utils").MkUpdater<{
            history: boolean;
            region_check_events: string;
            delete_check_events: string;
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        lspconfig?: import("./utils").MkUpdater<{
            server_default: {
                flags: {
                    debounce_text_changes: number;
                };
            };
            servers: {
                [k: string]: AnyTbl;
            };
            border: string;
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        null_ls?: import("./utils").MkUpdater<{
            debounce: number;
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        null_ls_sources?: import("./utils").MkUpdater<{
            formatters: {
                [k: string]: {};
            };
            linters: {
                [k: string]: {};
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        nightfox?: import("./utils").MkUpdater<{
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        nightfox_style?: import("./utils").MkUpdater<string & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        which_key?: import("./utils").MkUpdater<{
            plugins: {
                marks: boolean;
                registers: boolean;
                presets: {
                    operators: boolean;
                    motions: boolean;
                    text_objects: boolean;
                    windows: boolean;
                    nav: boolean;
                    z: boolean;
                    g: boolean;
                };
            };
            operators: {
                gc: string;
                gb: string;
            };
            window: {
                border: string;
            };
            layout: {
                align: string;
            };
            ignore_missing: boolean;
            show_help: boolean;
            triggers: string;
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        which_key_groups?: import("./utils").MkUpdater<{
            "<Leader>l": string;
            "<Leader>f": string;
            "<Leader>g": string;
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        gitsigns?: import("./utils").MkUpdater<{
            signcolumn: boolean;
            preview_config: {
                border: string;
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        telescope?: import("./utils").MkUpdater<{
            extensions: {
                fzf: {
                    fuzzy: boolean;
                    override_generic_sorter: boolean;
                    override_file_sorter: boolean;
                    case_mode: string;
                };
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        alpha?: import("./utils").MkUpdater<{
            header: (this: void) => string[];
            buttons: string[][];
            footer: (this: void) => string;
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        bufferline?: import("./utils").MkUpdater<{
            options: {
                numbers: string;
                diagnostics: string;
                show_buffer_icons: boolean;
                show_buffer_close_icons: boolean;
                show_close_icon: boolean;
                always_show_bufferline: boolean;
                offsets: {
                    filetype: string;
                    text: string;
                    text_align: string;
                }[];
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        lualine?: import("./utils").MkUpdater<{
            options: {
                theme: string;
                section_separators: string;
                component_separators: string;
                globalstatus: boolean;
            };
            sections: {
                lualine_a: {
                    1(this: void): " ";
                }[];
                lualine_b: {
                    1: string;
                }[];
                lualine_c: ({
                    1: string;
                    sources?: undefined;
                } | {
                    1: string;
                    sources: string[];
                })[];
                lualine_x: ({
                    1: string;
                    fmt: typeof string.upper;
                } | {
                    1: string;
                    fmt?: undefined;
                })[];
                lualine_y: {
                    1: string;
                }[];
                lualine_z: {
                    1: string;
                }[];
            };
            extensions: string[];
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        nvim_tree?: import("./utils").MkUpdater<{
            respect_buf_cwd: boolean;
            sync_root_with_cwd: boolean;
            update_focused_file: {
                enable: boolean;
                update_root: boolean;
            };
            actions: {
                open_file: {
                    resize_window: boolean;
                };
            };
            git: {
                enable: boolean;
                ignore: boolean;
                timeout: number;
            };
            filters: {
                custom: string[];
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
        toggleterm?: import("./utils").MkUpdater<{
            direction: string;
            float_opts: {
                border: string;
            };
        } & {
            [k: string]: any;
            [k: number]: any;
        }, false> | undefined;
    }) => void;
};
