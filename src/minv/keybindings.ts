import { mkHint, plug_key } from "./utils";

export type Binding = string[];

export type Keybindgs = { [k: string]: Binding };

export type KEYBINDINGS = typeof KEYBINDINGS;
export const KEYBINDINGS = mkHint<Keybindgs>()({
  // Bindings in normal mode
  "normal.nohlsearch": ["<Esc>"],
  "normal.save": ["<C-s>"],
  // Bindings in insert mode
  "insert.escape": ["jk", "jj"],
  // Bindings for `nvim-tree`
  "explorer.toggle": ["<C-n>"],
  "explorer.focus": ["<C-b>"],
  // Bindings for `bufferline`
  "buffer.close": ["<Leader>x"],
  "buffer.goto_next": ["<S-l>"],
  "buffer.goto_prev": ["<S-h>"],
  // Bidnings for `telescope`
  "telescope.buffers": ["<Leader>fb"],
  "telescope.document_symbols": ["<Leader>fs"],
  "telescope.files": ["<Leader>fF"],
  "telescope.git_commits": ["<Leader>fg"],
  "telescope.grep": ["<Leader>ff"],
  "telescope.marks": ["<Leader>fm"],
  "telescope.recent_files": ["<Leader>fo"],
  "telescope.registers": ["<Leader>fr"],
  "telescope.workspace_symbols": ["<Leader>fS"],
  // Bindings for `gitsigns`
  "git.blame_line": ["<Leader>gb"],
  "git.goto_next_hunk": ["]g"],
  "git.goto_prev_hunk": ["[g"],
  "git.preview_hunk": ["<Leader>gp"],
  "git.reset_buffer": ["<Leader>gR"],
  "git.reset_line": ["<Leader>gr"],
  "git.stage_buffer": ["<Leader>gS"],
  "git.state_hunk": ["<Leader>gs"],
  "git.undo_stage_hunk": ["<Leader>gu"],
  // Bindings for `Comment`
  "comment.insert_above": ["gcO"],
  "comment.insert_below": ["gco"],
  "comment.insert_eol": ["gcA"],
  "comment.oplead_block": ["gb"],
  "comment.oplead_line": ["gc"],
  "comment.toggle_block": ["gbc"],
  "comment.toggle_line": ["gcc"],
  // Bindings for `toggle-terminal`
  "terminal.toggle": ["<C-t>"],
  // Bindings for `lsp`
  "lsp.formatting": ["<Leader>lf"],
  "lsp.goto_declaration": ["gD"],
  "lsp.goto_definition": ["gd"],
  "lsp.goto_next_diagnostic": ["]d"],
  "lsp.goto_next_error": ["]e"],
  "lsp.goto_prev_diagnostic": ["[d"],
  "lsp.goto_prev_error": ["[e"],
  "lsp.hover": ["K"],
  "lsp.rename": ["<Leader>lr"],
  "lsp.show_code_action": ["<Leader>la"],
  "lsp.show_diagnostic": ["ge"],
  "lsp.show_document_diagnostics": ["<Leader>le"],
  "lsp.show_implementation": ["gI"],
  "lsp.show_references": ["gr"],
  "lsp.show_signature_help": ["gk"],
  "lsp.show_workspace_diagnostics": ["<Leader>lE"],
  // Bindings for `nvim-cmp`
  "cmp.close": ["<C-e>"],
  "cmp.complete": ["<C-Space>"],
  "cmp.confirm": ["<CR>"],
  "cmp.scroll_down": ["<C-d>"],
  "cmp.scroll_up": ["<C-u>"],
  "cmp.select_next": ["<Tab>"],
  "cmp.select_prev": ["<S-Tab>"],
});

export interface KeybindingOpts
  extends Omit<vim.keymap_opts, "callback" | "desc"> {}

export type BindingCmd = string | Lua.MkFn<() => void>;

const DEFAULT_OPTS: KeybindingOpts = {
  noremap: true,
  nowait: false,
  silent: true,
  script: false,
  expr: false,
  unique: false,
};

function mkOptions(opts: Partial<KeybindingOpts>): KeybindingOpts {
  const newOpts = {} as KeybindingOpts;
  for (const [k, v] of pairs(DEFAULT_OPTS)) {
    const v2 = opts[k];
    newOpts[k] = v2 != undefined ? v2 : v;
  }
  return newOpts;
}

let binding_handler = function (
  this: void,
  mode: string,
  buffer: number | undefined,
  lhs: string,
  cmd: BindingCmd,
  desc: string,
  options: KeybindingOpts
) {
  let callback;
  let rhs: string = "";
  if (type(cmd) == "function") {
    callback = cmd as (this: void) => void;
  } else {
    rhs = cmd as string;
  }
  const opts = vim.tbl_extend("keep", { desc, callback }, options);
  if (buffer == undefined) {
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts);
  } else {
    vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts);
  }
};

export function set_handler(this: void, new_handler: typeof binding_handler) {
  binding_handler = new_handler;
}

export type SourceOpts = Partial<KeybindingOpts> & {
  mode?: string;
  buffer?: number;
};

export type Source = SourceOpts & {
  cmd: BindingCmd;
  desc: string;
};

export type Mappings = {
  [K in keyof KEYBINDINGS]?: Source;
};

export function map_bindings(
  this: void,
  mappings: { [K in keyof KEYBINDINGS]?: any }
): { [k: string]: any } {
  const mapped = {} as AnyTable;
  for (const [name, val] of pairs(mappings)) {
    for (const [_, lhs] of ipairs(KEYBINDINGS[name])) {
      mapped[lhs] = val;
    }
  }
  return mapped;
}

export function apply_mappings(
  this: void,
  mappings: Mappings,
  gOpts?: SourceOpts
) {
  for (const [name, source] of pairs(mappings)) {
    const src = vim.tbl_extend("force", { mode: "n" }, source, gOpts ?? {});
    const opts = mkOptions(src);
    const { mode, buffer, cmd, desc } = src;
    for (const [_, lhs] of ipairs(KEYBINDINGS[name])) {
      binding_handler(mode, buffer, lhs, cmd, desc, opts);
    }
  }
}

export function mkPlugKeySrc<TNames extends keyof KEYBINDINGS>(
  this: void,
  descs: { [K in TNames]: string }
): { [K in TNames]: Source } {
  const keys: { [k: string]: Source } = {};
  for (const [name, desc] of pairs(descs)) {
    keys[name] = { cmd: plug_key(name), desc };
  }
  return keys as any;
}

export const COMMON_MAPPINGS = mkHint<Mappings>()({
  "insert.escape": {
    cmd: "<Esc>",
    desc: "Escape",
    mode: "i",
  },
  "normal.nohlsearch": {
    cmd: "<Cmd>nohlsearch<CR>",
    desc: "Stop hlsearch",
  },
  "normal.save": {
    cmd: "<Cmd>write<CR>",
    desc: "Save changes",
  },
});

export function setup(this: void) {
  apply_mappings(COMMON_MAPPINGS);
}
