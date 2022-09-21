import { autocmd } from "./utils";

export type Autocmds = typeof AUTOCMDS;
export const AUTOCMDS = {
  hl_yank: {
    enable: true,
    pat: "*",
    highgroup: "Search",
    timeout: 200,
  },
  format_on_save: {
    enable: true,
    pat: "*",
    timeout: undefined,
  },
  close: {
    enable: true,
    key: "q",
    ft: [
      "vim",
      "help",
      "man",
      "git",
      "qf",
      "lspinfo",
      "TelescopePrompt",
      "null-ls-info",
    ],
  },
  trim_spaces: {
    enable: true,
    pat: "*",
  },
  auto_resize: {
    enable: true,
    pat: "*",
  },
};

// TODO: add descriptions
const ARGS: {
  [K in keyof Autocmds]: (
    this: void,
    opts: Autocmds[K]
  ) => Parameters<typeof autocmd>;
} = {
  hl_yank: ({ pat, highgroup, timeout }) => [
    "TextYankPost",
    pat,
    () => {
      (require("vim.highlight") as AnyTbl).on_yank({ highgroup, timeout });
    },
  ],
  format_on_save: ({ pat, timeout }) => [
    "BufWritePre",
    pat,
    () => {
      vim.lsp.buf.formatting_sync(undefined, timeout);
    },
  ],
  close: ({ key, ft }) => [
    "FileType",
    ft,
    ({ buf }) => {
      vim.api.nvim_buf_set_keymap(buf, "", key, "close!", {
        silent: true,
        noremap: true,
      });
    },
  ],
  trim_spaces: ({ pat }) => ["BufWritePre", pat, `silent s/\s+$//e`],
  auto_resize: ({ pat }) => ["VimResized", pat, "wincmd ="],
};

export function setup(this: void) {
  for (const [name, opts] of pairs(AUTOCMDS)) {
    if (opts.enable) {
      const [event, pat, cmd, o] = unpack(ARGS[name](opts as any));
      autocmd(event, pat, cmd, o);
    }
  }
}
