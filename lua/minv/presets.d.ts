/// <reference types="spark/types" />
import * as spark from "spark";
import { MkUpdater } from "./utils";
declare type MkPresetsInput = {
    [k: string]: any;
};
declare type Table = {
    [k: string | number]: any;
};
declare type MkPresets<T extends MkPresetsInput> = {
    [K in keyof T]: T[K] & Table;
};
export interface SparkConfig extends DeepParitial<spark.Config> {
}
export declare type PRESETS = typeof PRESETS;
export declare const PRESETS: MkPresets<{
    spark: SparkConfig;
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
    };
    comment: {
        sticky: boolean;
        padding: boolean;
    };
    surround: {};
    cmp: {
        sources: {
            name: string;
            priority: number;
        }[];
        formatting: {
            fields: string[];
            format: (this: void, entry: any, vim_item: any) => any;
        };
    };
    cmp_formatting: {
        kind: LuaMap<string, string>;
        menu: LuaMap<string, string>;
        dup: LuaMap<string, boolean>;
    };
    luasnip: {
        history: boolean;
        region_check_events: string;
        delete_check_events: string;
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
    };
    null_ls: {
        debounce: number;
    };
    null_ls_sources: {
        formatters: {
            [k: string]: {};
        };
        linters: {
            [k: string]: {};
        };
    };
    nightfox: {};
    nightfox_style: string;
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
    };
    which_key_groups: {
        "<Leader>l": string;
        "<Leader>f": string;
        "<Leader>g": string;
    };
    gitsigns: {
        signcolumn: boolean;
        preview_config: {
            border: string;
        };
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
    };
    alpha: {
        header: (this: void) => string[];
        buttons: string[][];
        footer: (this: void) => string;
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
    };
    toggleterm: {
        direction: string;
        float_opts: {
            border: string;
        };
    };
}>;
export declare function update_preset(this: void, updater: {
    [K in keyof PRESETS]?: MkUpdater<PRESETS[K]>;
}): void;
export {};
