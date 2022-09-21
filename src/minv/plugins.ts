import { PRESETS } from "./presets";
import * as spark from "spark";
import { merge, mkHint } from "./utils";
import * as treesitter from "./plugins/treesitter";
import * as lsp from "./plugins/lsp";
import * as ui from "./plugins/ui";

export interface Plug extends Partial<Omit<spark.Spec, "from">> {}

export interface GroupSpec {
  priority: number;
  start: boolean;
  disable: boolean;
}

export interface PlugGroup extends GroupSpec {
  1: { [k: string]: Plug };
}

type MkSetupHook<T> = {
  [K in keyof T as K extends `$setup_${infer P}`
    ? `$pre_setup_${P}` | `$post_setup_${P}`
    : never]: Plug;
};

type MkPlugGroup<T extends PlugGroup> = {
  1: {
    [K in keyof T[1]]: Plug;
  } & MkSetupHook<T[1]> & { [k: string]: Plug | undefined };
} & GroupSpec;

type MkPluginsInput = { [k: string]: PlugGroup };

type MkPlugins<T extends MkPluginsInput> = {
  [K in keyof T]: MkPlugGroup<T[K]>;
};

function mkPlugins<T extends MkPluginsInput>(
  this: void,
  input: T
): MkPlugins<T> {
  const plugins = {} as LuaTable<string, PlugGroup>;
  for (const [gname, group] of pairs(input)) {
    const newplugs = {} as LuaTable<string, Plug>;
    for (const [pname, plug] of pairs(group[1])) {
      // Insert `$pre_setup_*` and `$post_setup_` hook.
      if (string.sub(pname as any, 1, 7) == "$setup_") {
        const refname = string.sub(pname as any, 8);
        const prename = "$pre_setup_" + refname;
        newplugs.set(prename, { after: plug.after });
        // Correct load order.
        plug.after = [prename];
        const postname = "$post_setup_" + refname;
        newplugs.set(postname, { after: [pname as any] });
      }
      newplugs.set(pname as any, plug);
    }
    group[1] = newplugs as any;
    plugins.set(gname as any, group);
  }
  return plugins as any;
}

const __INPUT = mkHint<MkPluginsInput>()({
  essional: {
    1: {
      impatient: { 1: "lewis6991/impatient.nvim", priority: 1 },
      $setup_impatient: {
        after: ["impatient"],
        setup() {
          require("impatient");
        },
      },
      spark: { 1: "loichyan/spark.nvim" },
      plenary: { 1: "nvim-lua/plenary.nvim" },
      web_devicons: { 1: "kyazdani42/nvim-web-devicons" },
    },
    priority: 5,
    start: true,
    disable: false,
  },
  treesitter: {
    1: {
      treesitter: { 1: "nvim-treesitter/nvim-treesitter", priority: 11 },
      $setup_treesitter: {
        after: ["treesitter"],
        setup: treesitter.setup_treesitter,
      },
      ts_context_commentstring: {
        1: "JoosepAlviste/nvim-ts-context-commentstring",
      },
      comment: { 1: "numToStr/Comment.nvim" },
      $setup_comment: {
        after: ["$setup_treesitter", "ts_context_commentstring", "comment"],
        setup: treesitter.setup_comment,
      },
      ts_textobjects: { 1: "nvim-treesitter/nvim-treesitter-textobjects" },
      surround: { 1: "kylechui/nvim-surround" },
      $setup_surround: {
        after: ["$setup_treesitter", "ts_textobjects", "surround"],
        setup: treesitter.setup_surround,
      },
    },
    priority: 15,
    start: true,
    disable: false,
  },
  cmp: {
    1: {
      cmp: { 1: "hrsh7th/nvim-cmp" },
      cmp_luasnip: { 1: "saadparwaiz1/cmp_luasnip" },
      cmp_nvim_lsp: { 1: "hrsh7th/cmp-nvim-lsp" },
      cmp_path: { 1: "hrsh7th/cmp-path" },
      cmp_buffer: { 1: "hrsh7th/cmp-buffer" },
      friendly_snippets: { 1: "rafamadriz/friendly-snippets" },
      luasnip: { 1: "L3MON4D3/LuaSnip" },
      $setup_cmp: {
        after: ["cmp", "luasnip"],
        setup: require("./plugins/cmp").setup,
      },
    },
    priority: 25,
    start: true,
    disable: false,
  },
  lsp: {
    1: {
      lspconfig: { 1: "neovim/nvim-lspconfig" },
      $setup_lspconfig: {
        after: ["lspconfig"],
        setup: lsp.setup_lspconfig,
      },
      null_ls: { 1: "jose-elias-alvarez/null-ls.nvim" },
      $setup_null_ls: {
        after: ["null_ls"],
        setup: lsp.setup_null_ls,
      },
    },
    priority: 35,
    start: true,
    disable: false,
  },
  ui: {
    1: {
      nightfox: { 1: "EdenEast/nightfox.nvim", priority: 41 },
      $setup_nightfox: {
        after: ["nightfox"],
        setup() {
          (require("nightfox") as AnyTbl).setup(PRESETS.nightfox);
          vim.cmd(string.format("colorscheme %s", PRESETS.nightfox_style));
        },
      },
      whick_key: { 1: "folke/which-key.nvim" },
      $setup_which_key: {
        after: ["whick_key"],
        setup: ui.setup_which_key,
      },
      gitsigns: { 1: "lewis6991/gitsigns.nvim" },
      $setup_gitsigns: {
        after: ["gitsigns"],
        setup: ui.setup_gitsigns,
      },
      telescope: { 1: "nvim-telescope/telescope.nvim" },
      telescope_fzf_native: {
        1: "nvim-telescope/telescope-fzf-native.nvim",
        run: ["make"],
      },
      $setup_telescope: {
        after: ["telescope", "telescope_fzf_native"],
        setup: ui.setup_telescope,
      },
      alpha: { 1: "goolord/alpha-nvim" },
      $setup_alpha: {
        after: ["alpha"],
        setup: ui.setup_alpha,
      },
      bufferline: { 1: "akinsho/bufferline.nvim" },
      $setup_bufferline: {
        after: ["bufferline"],
        setup: ui.setup_bufferline,
      },
      lualine: { 1: "nvim-lualine/lualine.nvim" },
      $setup_lualine: {
        after: ["lualine"],
        setup: ui.setup_lualine,
      },
      nvim_tree: { 1: "kyazdani42/nvim-tree.lua" },
      $setup_nvim_tree: {
        after: ["nvim_tree"],
        setup: ui.setup_nvim_tree,
      },
      toggleterm: { 1: "akinsho/toggleterm.nvim" },
      $setup_toggleterm: {
        after: ["toggleterm"],
        setup: ui.setup_toggleterm,
      },
    },
    priority: 45,
    start: true,
    disable: false,
  },
  extra: {
    1: {},
    priority: 95,
    start: true,
    disable: false,
  },
});

export type PLUGINS = typeof PLUGINS;
export const PLUGINS = mkPlugins(__INPUT);

export function collect_plugins(this: void): Plug[] {
  const plugs: Plug[] = [];
  for (const [_, group] of pairs(PLUGINS)) {
    const gSpec = {
      priority: group.priority,
      start: group.start,
      disable: group.disable,
    };
    for (const [name, spec] of pairs(group[1])) {
      table.insert(
        plugs,
        vim.tbl_extend(
          "keep",
          { 1: name as string, from: spec[1] },
          spec,
          gSpec
        )
      );
    }
  }
  return plugs;
}

export function extend_plugins(
  this: void,
  input: {
    [K in keyof PLUGINS]?: Partial<
      {
        1: Record<string, Plug> & Partial<MkSetupHook<PLUGINS[K][1]>>;
      } & GroupSpec
    >;
  }
) {
  for (const [gname, group] of pairs(input)) {
    const oldgroup = PLUGINS[gname];
    const plugs = oldgroup[1];
    if (group[1] != undefined) {
      // Update/extend plugins.
      for (const [pname, plug] of pairs(group[1])) {
        const oldplug = plugs[pname as string];
        if (oldplug != undefined) {
          merge("force", oldplug, plug);
        } else {
          plugs[pname as string] = plug;
        }
      }
    }
    // Update group spec.
    merge("force", oldgroup, group, { 1: plugs });
  }
}
