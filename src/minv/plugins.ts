import { PRESETS } from "./presets";
import { Spec } from "spark/shared";
import { mkHint } from "./utils";
import * as treeistter from "./plugins/treesitter";
import * as lsp from "./plugins/lsp";
import * as ui from "./plugins/ui";

export interface Plug extends Omit<Spec, "from"> {
  1: string;
}

export interface PlugGroup {
  1: { [k: string]: DeepParitial<Plug> };
  priority: number;
  start: boolean;
  disable: boolean;
}

export type Plugins = { [k: string]: PlugGroup };

export const PLUGINS = mkHint<Plugins>()({
  essional: {
    1: {
      impatient: { 1: "lewis6991/impatient.nvim", priority: 1 },
      $setup_impatien: {
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
  treeistter: {
    1: {
      treesitter: { 1: "nvim-treesitter/nvim-treesitter" },
      $setup_treesitter: {
        after: ["treesitter"],
        setup: treeistter.setup_treesitter,
      },
      ts_context_commentstring: {
        1: "JoosepAlviste/nvim-ts-context-commentstring",
      },
      comment: { 1: "numToStr/Comment.nvim" },
      $setup_comment: {
        after: ["$setup_treesitter", "ts_context_commentstring", "comment"],
        setup: treeistter.setup_comment,
      },
      ts_textobjects: { 1: "nvim-treesitter/nvim-treesitter-textobjects" },
      surround: { 1: "kylechui/nvim-surround" },
      $setup_surround: {
        after: ["$setup_treesitter", "ts_textobjects", "surround"],
        setup: treeistter.setup_surround,
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

export function collect_plugins(this: void): Partial<Plug>[] {
  const plugs: Partial<Plug>[] = [];
  for (const [_, group] of pairs(PLUGINS as Plugins)) {
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
