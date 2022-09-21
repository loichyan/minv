export declare type Autocmds = typeof AUTOCMDS;
export declare const AUTOCMDS: {
    hl_yank: {
        enable: boolean;
        pat: string;
        highgroup: string;
        timeout: number;
    };
    format_on_save: {
        enable: boolean;
        pat: string;
        timeout: undefined;
    };
    close: {
        enable: boolean;
        key: string;
        ft: string[];
    };
    trim_spaces: {
        enable: boolean;
        pat: string;
    };
    auto_resize: {
        enable: boolean;
        pat: string;
    };
};
export declare function setup(this: void): void;
