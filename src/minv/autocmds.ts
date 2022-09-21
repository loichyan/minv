import { autocmd } from "./utils";

export type Autocmds = typeof AUTOCMDS;
export const AUTOCMDS = {
  hl_yank: {
    enable: true,
    pattern: "*",
    highgroup: "Search",
    timeout: 200,
  },
  format_on_save: {
    enable: true,
    pattern: "*",
    timeout: undefined,
  },
  close: {
    enable: true,
    key: "q",
    filetype: [
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
    pattern: "*",
  },
  auto_resize: {
    enable: true,
    pattern: "*",
  },
  // TODO: ruler
};

// TODO: add descriptions
const ARGS: {
  [K in keyof Autocmds]: (
    this: void,
    opts: Autocmds[K]
  ) => Parameters<typeof autocmd>;
} = {
  hl_yank: ({ pattern, highgroup, timeout }) => [
    "TextYankPost",
    () => {
      (require("vim.highlight") as AnyTbl).on_yank({ highgroup, timeout });
    },
    { pattern },
  ],
  format_on_save: ({ pattern, timeout }) => [
    "BufWritePre",
    () => {
      vim.lsp.buf.formatting_sync(undefined, timeout);
    },
    { pattern },
  ],
  close: ({ key, filetype }) => [
    "FileType",
    ({ buf }) => {
      vim.api.nvim_buf_set_keymap(buf, "", key, "<Cmd>q!<CR>", {
        silent: true,
        noremap: true,
      });
    },
    { pattern: filetype },
  ],
  trim_spaces: ({ pattern }) => [
    "BufWritePre",
    `silent s/\s+$//e`,
    { pattern },
  ],
  auto_resize: ({ pattern }) => ["VimResized", "wincmd =", { pattern }],
};

export function setup_autocmds(this: void) {
  for (const [name, opts] of pairs(AUTOCMDS)) {
    if (opts.enable) {
      const [event, cmd, o] = unpack(ARGS[name](opts as any));
      autocmd(event, cmd, o);
    }
  }
}
