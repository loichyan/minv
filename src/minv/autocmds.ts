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
  ruler: {
    enable: true,
    offsets: {} as Record<string, number>,
  },
};

// TODO: add descriptions
const ARGS: {
  [K in keyof Autocmds]: (this: void, opts: Autocmds[K]) => void;
} = {
  hl_yank: ({ pattern, highgroup, timeout }) =>
    autocmd(
      "TextYankPost",
      () => {
        (require("vim.highlight") as AnyTbl).on_yank({ highgroup, timeout });
      },
      { pattern }
    ),
  format_on_save: ({ pattern, timeout }) =>
    autocmd(
      "BufWritePre",
      () => {
        vim.lsp.buf.formatting_sync(undefined, timeout);
      },
      { pattern }
    ),
  close: ({ key, filetype }) =>
    autocmd(
      "FileType",
      ({ buf }) => {
        vim.api.nvim_buf_set_keymap(buf, "", key, "<Cmd>q!<CR>", {
          silent: true,
          noremap: true,
        });
      },
      { pattern: filetype }
    ),
  trim_spaces: ({ pattern }) =>
    autocmd("BufWritePre", `silent s/\s+$//e`, { pattern }),
  auto_resize: ({ pattern }) => autocmd("VimResized", "wincmd =", { pattern }),
  ruler: ({ offsets }) => {
    for (const [ft, offs] of pairs(offsets)) {
      autocmd("FileType", string.format("setlocal colorcolumn=%d", offs), {
        pattern: ft,
      });
    }
  },
};

export function setup_autocmds(this: void) {
  for (const [name, opts] of pairs(AUTOCMDS)) {
    if (opts.enable) {
      ARGS[name](opts as any);
    }
  }
}
