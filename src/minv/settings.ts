export type Settings = typeof SETTINGS;
export const SETTINGS = {
  g: {
    mapleader: " ",
    markdown_fenced_languages: ["bash", "c", "json", "lua", "python", "sh"],
  },
  o: {
    clipboard: "unnamed",
    mouse: "a",
    timeoutlen: 300,
    updatetime: 300,
    autoread: true,
    expandtab: true,
    tabstop: 4,
    shiftwidth: 4,
    autoindent: true,
    hlsearch: true,
    ignorecase: true,
    smartcase: true,
    swapfile: false,
    undofile: true,
    number: true,
    relativenumber: true,
    hidden: true,
    title: true,
    signcolumn: "yes",
    termguicolors: true,
    showmode: false,
    splitbelow: true,
    splitright: true,
  },
};

export function setup(this: void) {
  for (const [k, v] of pairs(SETTINGS.g)) {
    vim.g[k] = v;
  }
  for (const [k, v] of pairs(SETTINGS.o)) {
    vim.o[k] = v;
  }
}
