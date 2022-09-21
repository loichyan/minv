/// <reference types="spark/types" />
import { Spec } from "spark/shared";
import * as treeistter from "./plugins/treesitter";
import * as lsp from "./plugins/lsp";
import * as ui from "./plugins/ui";
export interface Plug extends Omit<Spec, "from"> {
    1: string;
}
export interface PlugGroup {
    1: {
        [k: string]: DeepParitial<Plug>;
    };
    priority: number;
    start: boolean;
    disable: boolean;
}
export declare type Plugins = {
    [k: string]: PlugGroup;
};
export declare const PLUGINS: {
    essional: {
        1: {
            impatient: {
                1: string;
                priority: number;
            };
            $setup_impatien: {
                after: string[];
                setup(this: void): void;
            };
            spark: {
                1: string;
            };
            plenary: {
                1: string;
            };
            web_devicons: {
                1: string;
            };
        };
        priority: number;
        start: true;
        disable: false;
    };
    treeistter: {
        1: {
            treesitter: {
                1: string;
            };
            $setup_treesitter: {
                after: string[];
                setup: typeof treeistter.setup_treesitter;
            };
            ts_context_commentstring: {
                1: string;
            };
            comment: {
                1: string;
            };
            $setup_comment: {
                after: string[];
                setup: typeof treeistter.setup_comment;
            };
            ts_textobjects: {
                1: string;
            };
            surround: {
                1: string;
            };
            $setup_surround: {
                after: string[];
                setup: typeof treeistter.setup_surround;
            };
        };
        priority: number;
        start: true;
        disable: false;
    };
    cmp: {
        1: {
            cmp: {
                1: string;
            };
            cmp_luasnip: {
                1: string;
            };
            cmp_nvim_lsp: {
                1: string;
            };
            cmp_path: {
                1: string;
            };
            cmp_buffer: {
                1: string;
            };
            friendly_snippets: {
                1: string;
            };
            luasnip: {
                1: string;
            };
            $setup_cmp: {
                after: string[];
                setup: any;
            };
        };
        priority: number;
        start: true;
        disable: false;
    };
    lsp: {
        1: {
            lspconfig: {
                1: string;
            };
            $setup_lspconfig: {
                after: string[];
                setup: typeof lsp.setup_lspconfig;
            };
            null_ls: {
                1: string;
            };
            $setup_null_ls: {
                after: string[];
                setup: typeof lsp.setup_null_ls;
            };
        };
        priority: number;
        start: true;
        disable: false;
    };
    ui: {
        1: {
            nightfox: {
                1: string;
                priority: number;
            };
            $setup_nightfox: {
                after: string[];
                setup(this: void): void;
            };
            whick_key: {
                1: string;
            };
            $setup_which_key: {
                after: string[];
                setup: typeof ui.setup_which_key;
            };
            gitsigns: {
                1: string;
            };
            $setup_gitsigns: {
                after: string[];
                setup: typeof ui.setup_gitsigns;
            };
            telescope: {
                1: string;
            };
            telescope_fzf_native: {
                1: string;
                run: string[];
            };
            $setup_telescope: {
                after: string[];
                setup: typeof ui.setup_telescope;
            };
            alpha: {
                1: string;
            };
            $setup_alpha: {
                after: string[];
                setup: typeof ui.setup_alpha;
            };
            bufferline: {
                1: string;
            };
            $setup_bufferline: {
                after: string[];
                setup: typeof ui.setup_bufferline;
            };
            lualine: {
                1: string;
            };
            $setup_lualine: {
                after: string[];
                setup: typeof ui.setup_lualine;
            };
            nvim_tree: {
                1: string;
            };
            $setup_nvim_tree: {
                after: string[];
                setup: typeof ui.setup_nvim_tree;
            };
            toggleterm: {
                1: string;
            };
            $setup_toggleterm: {
                after: string[];
                setup: typeof ui.setup_toggleterm;
            };
        };
        priority: number;
        start: true;
        disable: false;
    };
    extra: {
        1: {};
        priority: number;
        start: true;
        disable: false;
    };
};
export declare function collect_plugins(this: void): Partial<Plug>[];
