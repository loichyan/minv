export declare type Settings = typeof SETTINGS;
export declare const SETTINGS: {
    g: {
        mapleader: string;
        markdown_fenced_languages: string[];
    };
    o: {
        clipboard: string;
        mouse: string;
        timeoutlen: number;
        updatetime: number;
        autoread: boolean;
        expandtab: boolean;
        tabstop: number;
        shiftwidth: number;
        autoindent: boolean;
        hlsearch: boolean;
        ignorecase: boolean;
        smartcase: boolean;
        swapfile: boolean;
        undofile: boolean;
        number: boolean;
        relativenumber: boolean;
        hidden: boolean;
        title: boolean;
        signcolumn: string;
        termguicolors: boolean;
        showmode: boolean;
        splitbelow: boolean;
        splitright: boolean;
    };
};
export declare function setup(this: void): void;
