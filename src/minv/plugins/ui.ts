import {
  apply_extra,
  apply_mappings,
  Mappings,
  mkPlugKeySrc,
} from "../keybindings";
import { PRESETS } from "../presets";
import { autocmd, deep_merge } from "../utils";

const MAPPINGS_GIT: Mappings = {
  "git.blame_line": {
    cmd: "<Cmd>Gitsigns blame_line<CR>",
    desc: "Blame line",
  },
  "git.goto_next_hunk": {
    cmd: "<Cmd>Gitsigns next_hunk<CR>",
    desc: "Goto next hunk",
  },
  "git.goto_prev_hunk": {
    cmd: "<Cmd>Gitsigns prev_hunk<CR>",
    desc: "Goto prev hunk",
  },
  "git.preview_hunk": {
    cmd: "<Cmd>Gitsigns preview_hunk<CR>",
    desc: "Preview hunk",
  },
  "git.reset_buffer": {
    cmd: "<Cmd>Gitsigns reset_buffer<CR>",
    desc: "Reset buffer",
  },
  "git.reset_line": {
    cmd: "<Cmd>Gitsigns reset_hunk<CR>",
    desc: "Reset hunk",
  },
  "git.stage_buffer": {
    cmd: "<Cmd>Gitsigns stage_buffer<CR>",
    desc: "Stage buffer",
  },
  "git.state_hunk": {
    cmd: "<Cmd>Gitsigns stage_hunk<CR>",
    desc: "Stage hunk",
  },
  "git.undo_stage_hunk": {
    cmd: "<Cmd>Gitsigns undo_stage_hunk<CR>",
    desc: "Undo stage hunk",
  },
};

const MAPPINGS_TELESCOPE: Mappings = {
  "telescope.buffers": {
    cmd: "<Cmd>Telescope buffers<CR>",
    desc: "Search buffers",
  },
  "telescope.document_symbols": {
    cmd: "<Cmd>Telescope lsp_document_symbols<CR>",
    desc: "Search document symbols",
  },
  "telescope.files": {
    cmd: "<Cmd>Telescope find_files<CR>",
    desc: "Search files",
  },
  "telescope.git_commits": {
    cmd: "<Cmd>Telescope git_commits<CR>",
    desc: "Search git commits",
  },
  "telescope.grep": {
    cmd: "<Cmd>Telescope live_grep<CR>",
    desc: "Search strings",
  },
  "telescope.marks": {
    cmd: "<Cmd>Telescope marks<CR>",
    desc: "Search marks",
  },
  "telescope.recent_files": {
    cmd: "<Cmd>Telescope oldfiles<CR>",
    desc: "Search recent files",
  },
  "telescope.registers": {
    cmd: "<Cmd>Telescope registers<CR>",
    desc: "Search registers",
  },
  "telescope.workspace_symbols": {
    cmd: "<Cmd>Telescope lsp_workspace_symbols<CR>",
    desc: "Search workspace symbols",
  },
};

const MAPPINGS_BUFFER: Mappings = {
  "bufferline.close": {
    cmd: "<Cmd>bdelete<CR>",
    desc: "Close buffer",
  },
  "bufferline.goto_next": {
    cmd: "<Cmd>BufferLineCycleNext<CR>",
    desc: "Goto next buffer",
  },
  "bufferline.goto_prev": {
    cmd: "<Cmd>BufferLineCyclePrev<CR>",
    desc: "Goto prev buffer",
  },
};

const MAPPINGS_TREE: Mappings = {
  "tree.toggle": {
    cmd: "<Cmd>NvimTreeToggle<CR>",
    desc: "Toggle tree",
  },
  "tree.focus": {
    cmd: "<Cmd>NvimTreeFocus<CR>",
    desc: "Focus tree",
  },
};

const MAPPINGS_TOGGLETERM = mkPlugKeySrc({
  "terminal.toggle": "Toggle terminal",
});

export function setup_which_key(this: void) {
  const which_key = require("which-key") as AnyTbl;
  which_key.setup(PRESETS.which_key);
  // Register groups.
  const groups = {} as any as LuaMap;
  for (const [key, name] of pairs(PRESETS.which_key_groups)) {
    groups.set(key, { name });
  }
  which_key.register(groups);
}

export function setup_gitsigns(this: void) {
  (require("gitsigns") as AnyTbl).setup(PRESETS.gitsigns);
  apply_mappings(MAPPINGS_GIT);
  apply_extra("git.extra", { mode: "n" });
}

export function setup_telescope(this: void) {
  const telescope = require("telescope") as AnyTbl;
  telescope.setup(PRESETS.telescope);
  telescope.load_extension("fzf");
  apply_mappings(MAPPINGS_TELESCOPE);
  apply_extra("telescope.extra", { mode: "n" });
}

export function setup_alpha(this: void) {
  const preset = PRESETS.alpha;
  const dashboard = require("alpha.themes.dashboard") as AnyTbl;
  // Load UI elemens.
  const header = dashboard.section.header;
  const buttons = dashboard.section.buttons;
  const footer = dashboard.section.footer;
  // Header
  header.val = preset.header() as any;
  header.opts.hl = "DashboardHeader" as any;
  // Buttons
  buttons.val = [] as any;
  for (const [_, val] of ipairs(preset.buttons)) {
    const btn = dashboard.button(...unpack(val));
    btn.opts.hl = "DashboardCenter";
    btn.opts.hl_shortcut = "DashboardShortcut";
    table.insert(buttons.val as any, btn);
  }
  // Footer
  footer.val = preset.footer() as any;
  footer.opts.hl = "DashboardFooter" as any;
  (require("alpha") as AnyTbl).setup(dashboard.config);
  // Auto hide tabline.
  autocmd(
    "User",
    ({ buf }) => {
      vim.cmd("set showtabline=0");
      autocmd("BufUnload", "set showtabline=2", { once: true, buffer: buf });
    },
    { pattern: "AlphaReady" }
  );
}

export function setup_bufferline(this: void) {
  (require("bufferline") as AnyTbl).setup(PRESETS.bufferline);
  apply_mappings(MAPPINGS_BUFFER);
  apply_extra("bufferline.extra", { mode: "n" });
}

export function setup_lualine(this: void) {
  (require("lualine") as AnyTbl).setup(PRESETS.lualine);
}

export function setup_nvim_tree(this: void) {
  (require("nvim-tree") as AnyTbl).setup(PRESETS.nvim_tree);
  apply_mappings(MAPPINGS_TREE);
  apply_extra("tree.extra", { mode: "n" });
}

export function setup_toggleterm(this: void) {
  const preset = PRESETS.toggleterm;
  (require("toggleterm") as AnyTbl).setup(
    deep_merge(
      "keep",
      {
        insert_mappings: true,
        terminal_mappings: true,
        open_mapping: MAPPINGS_TOGGLETERM["terminal.toggle"].cmd,
        on_open(this: void, term: AnyTbl) {
          apply_mappings(MAPPINGS_TOGGLETERM, {
            mode: "t",
            noremap: false,
            buffer: term.bufnr as any,
          });
          apply_extra("terminal.extra", {
            mode: "t",
            buffer: term.bufnr as any,
          });
          const on_open = (preset as any as AnyTbl).on_open;
          if (on_open != undefined) {
            on_open(term);
          }
        },
      },
      preset
    )
  );
  apply_mappings(MAPPINGS_TOGGLETERM, { noremap: false });
}
