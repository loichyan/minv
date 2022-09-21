import {
  apply_updater,
  KeymapCmd,
  KeymapOpts,
  merge,
  mkHint,
  MkUpdater,
  plug_key,
  set_keymap,
} from "./utils";

export interface Source extends KeymapOpts {
  cmd: KeymapCmd;
}

type ConcatKey<K, Pref extends string> = K extends string
  ? `${Pref}.${K}`
  : "12";

type MkBindingsKey<T, K extends keyof T> = K extends string
  ? ConcatKey<keyof T[K], K>
  : never;

type MkExtraKey<K> = K extends string ? ConcatKey<"extra", K> : never;

type MkKeybindigsInput = { [k: string]: { [k: string]: string[] } };

type MkKeybindigs<T extends MkKeybindigsInput> = {
  [K in MkBindingsKey<T, keyof T>]: string[];
} & {
  [K in MkExtraKey<keyof T>]: { [k: string]: Source };
};

function mkKeybindings<T extends MkKeybindigsInput>(
  this: void,
  input: T
): MkKeybindigs<T> {
  const kb: { [k: string]: any } = {};
  for (const [domain, bindings] of pairs(input)) {
    for (const [name, binding] of pairs(bindings)) {
      kb[string.format("%s.%s", domain, name)] = binding;
    }
    kb[string.format("%s.extra", domain)] = {};
  }
  return kb as any;
}

const __INPUT = mkHint<MkKeybindigsInput>()({
  // Bindings in normal mode
  normal: {
    nohlsearch: ["<Esc>"],
    save: ["<C-s>"],
  },
  // Bindings in insert mode
  insert: {
    escape: ["jk", "jj"],
  },
  // Bindings for `nvim-tree`
  tree: {
    toggle: ["<C-n>"],
    focus: ["<C-b>"],
  },
  // Bindings for `bufferline`
  bufferline: {
    close: ["<Leader>x"],
    goto_next: ["<S-l>"],
    goto_prev: ["<S-h>"],
  },
  // Bindings for `telescope`
  telescope: {
    buffers: ["<Leader>fb"],
    document_symbols: ["<Leader>fs"],
    files: ["<Leader>fF"],
    git_commits: ["<Leader>fg"],
    grep: ["<Leader>ff"],
    marks: ["<Leader>fm"],
    recent_files: ["<Leader>fo"],
    registers: ["<Leader>fr"],
    workspace_symbols: ["<Leader>fS"],
  },
  // Bindings for `gitsigns`
  git: {
    blame_line: ["<Leader>gb"],
    goto_next_hunk: ["]g"],
    goto_prev_hunk: ["[g"],
    preview_hunk: ["<Leader>gp"],
    reset_buffer: ["<Leader>gR"],
    reset_line: ["<Leader>gr"],
    stage_buffer: ["<Leader>gS"],
    state_hunk: ["<Leader>gs"],
    undo_stage_hunk: ["<Leader>gu"],
  },
  // Bindings for `Comment`
  comment: {
    insert_above: ["gcO"],
    insert_below: ["gco"],
    insert_eol: ["gcA"],
    oplead_block: ["gb"],
    oplead_line: ["gc"],
    toggle_block: ["gbc"],
    toggle_line: ["gcc"],
  },
  // Bindings for `toggle-terminal`
  terminal: {
    toggle: ["<C-t>"],
  },
  // Bindings for `lsp`
  lsp: {
    formatting: ["<Leader>lf"],
    goto_declaration: ["gD"],
    goto_definition: ["gd"],
    goto_next_diagnostic: ["]d"],
    goto_next_error: ["]e"],
    goto_prev_diagnostic: ["[d"],
    goto_prev_error: ["[e"],
    hover: ["K"],
    rename: ["<Leader>lr"],
    show_code_action: ["<C-k>"],
    show_diagnostic: ["ge"],
    show_document_diagnostics: ["<Leader>le"],
    show_implementation: ["gI"],
    show_references: ["gr"],
    show_signature_help: ["gk"],
    show_workspace_diagnostics: ["<Leader>lE"],
  },
  // Bindings for `nvim-cmp`
  cmp: {
    close: ["<C-e>"],
    complete: ["<C-Space>"],
    confirm: ["<CR>"],
    scroll_down: ["<C-d>"],
    scroll_up: ["<C-u>"],
    select_next: ["<Tab>"],
    select_prev: ["<S-Tab>"],
  },
});

type BindingKeys = MkBindingsKey<typeof __INPUT, keyof typeof __INPUT>;
type ExtraKeys = MkExtraKey<keyof typeof __INPUT>;

export type KEYBINDINGS = typeof KEYBINDINGS;
export const KEYBINDINGS = mkKeybindings(__INPUT);

export type Mappings = {
  [K in BindingKeys]?: Source;
};

export function map_bindings(
  this: void,
  mappings: { [K in BindingKeys]?: any }
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
  gopts?: KeymapOpts
) {
  for (const [name, source] of pairs(mappings)) {
    const opts = vim.tbl_extend("force", {}, source, gopts ?? {});
    for (const [_, lhs] of ipairs(KEYBINDINGS[name])) {
      set_keymap(lhs, source.cmd, opts);
    }
  }
}

export function apply_extra(this: void, key: ExtraKeys, gopts?: KeymapOpts) {
  for (const [lhs, src] of pairs(KEYBINDINGS[key])) {
    const opts = vim.tbl_extend("force", {}, gopts ?? {}, src);
    set_keymap(lhs as string, src.cmd, opts);
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

export function setup_keybindings(this: void) {
  apply_mappings(COMMON_MAPPINGS);
  apply_extra("insert.extra", { mode: "i" });
  apply_extra("normal.extra", { mode: "n" });
}

export function update_keybindings(
  this: void,
  updater: MkUpdater<KEYBINDINGS, true>
) {
  apply_updater(KEYBINDINGS, updater);
}
