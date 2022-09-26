export declare type Autocmds = typeof AUTOCMDS;
export declare const AUTOCMDS: {
    hl_yank: {
        enable: boolean;
        pattern: string;
        highgroup: string;
        timeout: number;
    };
    format_on_save: {
        enable: boolean;
        pattern: string;
        timeout: undefined;
    };
    close: {
        enable: boolean;
        key: string;
        filetype: string[];
    };
    trim_spaces: {
        enable: boolean;
        pattern: string;
    };
    auto_resize: {
        enable: boolean;
        pattern: string;
    };
    ruler: {
        enable: boolean;
        offsets: Record<string, number>;
    };
};
export declare function setup_autocmds(this: void): void;
