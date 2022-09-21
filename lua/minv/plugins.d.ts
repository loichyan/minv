import * as spark from "spark";
import * as treesitter from "./plugins/treesitter";
import * as lsp from "./plugins/lsp";
import * as ui from "./plugins/ui";
export interface Plug extends Partial<Omit<spark.Spec, "from">> {
}
export interface GroupSpec {
    priority: number;
    start: boolean;
    disable: boolean;
}
export interface PlugGroup extends GroupSpec {
    1: {
        [k: string]: Plug;
    };
}
declare type MkSetupHook<T> = {
    [K in keyof T as K extends `$setup_${infer P}` ? `$pre_setup_${P}` | `$post_setup_${P}` : never]: Plug;
};
declare type MkPlugGroup<T extends PlugGroup> = {
    1: {
        [K in keyof T[1]]: Plug;
    } & MkSetupHook<T[1]> & {
        [k: string]: Plug | undefined;
    };
} & GroupSpec;
declare type MkPluginsInput = {
    [k: string]: PlugGroup;
};
declare type MkPlugins<T extends MkPluginsInput> = {
    [K in keyof T]: MkPlugGroup<T[K]>;
};
export declare type PLUGINS = typeof PLUGINS;
export declare const PLUGINS: MkPlugins<{
    essional: {
        1: {
            impatient: {
                1: string;
                priority: number;
            };
            $setup_impatient: {
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
    treesitter: {
        1: {
            treesitter: {
                1: string;
                priority: number;
            };
            $setup_treesitter: {
                after: string[];
                setup: typeof treesitter.setup_treesitter;
            };
            ts_context_commentstring: {
                1: string;
            };
            comment: {
                1: string;
            };
            $setup_comment: {
                after: string[];
                setup: typeof treesitter.setup_comment;
            };
            ts_textobjects: {
                1: string;
            };
            surround: {
                1: string;
            };
            $setup_surround: {
                after: string[];
                setup: typeof treesitter.setup_surround;
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
}>;
export declare function collect_plugins(this: void): Plug[];
export declare function extend_plugins(this: void, input: {
    [K in keyof PLUGINS]?: Partial<{
        1: Record<string, Plug> & Partial<MkSetupHook<PLUGINS[K][1]>>;
    } & GroupSpec>;
}): void;
export {};
